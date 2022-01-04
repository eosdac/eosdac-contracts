#include <eosio/action.hpp>
#include <eosio/crypto.hpp>
#include <eosio/permission.hpp>

#include "msigworlds.hpp"

namespace eosio {

    transaction_header get_trx_header(const char *ptr, size_t sz);
    bool trx_is_authorized(const std::vector<permission_level> &approvals, const std::vector<char> &packed_trx);

    template <typename Function>
    std::vector<permission_level> get_approvals_and_adjust_table(
        name self, name proposal_name, Function &&table_op, name dac_id) {
        approvals approval_table(self, dac_id.value);
        auto      approval_table_iter =
            approval_table.require_find(proposal_name.value, "ERR::NO_APPROVALS_FOUND::No approvals were found.");
        std::vector<permission_level> approvals_vector;

        invalidations invalidations_table(self, dac_id.value);

        approvals_vector.reserve(approval_table_iter->provided_approvals.size());
        for (const auto &permission : approval_table_iter->provided_approvals) {
            auto iter = invalidations_table.find(permission.level.actor.value);
            if (iter == invalidations_table.end() || iter->last_invalidation_time < permission.time) {
                approvals_vector.push_back(permission.level);
            }
        }
        table_op(approval_table, approval_table_iter);

        return approvals_vector;
    }

    void multisig::propose(name proposer, name proposal_name, std::vector<permission_level> requested, name dac_id,
        std::map<std::string, std::string> metadata, ignore<transaction> trx) {
        require_auth(proposer);
        auto &ds = get_datastream();

        const char *trx_pos = ds.pos();
        size_t      size    = ds.remaining();

        transaction_header  trx_header;
        std::vector<action> context_free_actions;
        ds >> trx_header;
        check(trx_header.expiration >= eosio::time_point_sec(current_time_point()), "transaction expired");
        ds >> context_free_actions;
        check(context_free_actions.empty(), "not allowed to `propose` a transaction with context-free actions");

        proposals proptable(get_self(), dac_id.value);
        check(proptable.find(proposal_name.value) == proptable.end(), "proposal with the same name exists");

        auto packed_requested = pack(requested);
        auto res              = check_transaction_authorization(
            trx_pos, size, (const char *)0, 0, packed_requested.data(), packed_requested.size());

        check(res > 0, "transaction authorization failed");

        std::vector<char> pkd_trans;
        pkd_trans.resize(size);
        memcpy((char *)pkd_trans.data(), trx_pos, size);

        proptable.emplace(proposer, [&](proposal &prop) {
            prop.proposal_name      = proposal_name;
            prop.proposer           = proposer;
            prop.packed_transaction = pkd_trans;
            prop.earliest_exec_time = std::optional<time_point>{};
            prop.modified_date      = time_point_sec(eosio::current_time_point());
            prop.state              = PropState::PENDING;
            prop.metadata           = metadata;
        });

        approvals apptable(get_self(), proposer.value);
        apptable.emplace(proposer, [&](auto &a) {
            a.proposal_name = proposal_name;
            a.requested_approvals.reserve(requested.size());
            for (auto &level : requested) {
                a.requested_approvals.push_back(approval{level, time_point{microseconds{0}}});
            }
        });
    }

    void multisig::approve(name proposal_name, permission_level level, name dac_id,
        const eosio::binary_extension<eosio::checksum256> &proposal_hash) {
        if (level.permission == "eosio.code"_n) {
            check(get_sender() == level.actor, "wrong contract sent `approve` action for eosio.code permmission");
        } else {
            require_auth(level);
        }

        proposals proptable(get_self(), dac_id.value);
        auto &    prop = proptable.get(proposal_name.value, "proposal not found");
        check(prop.state == PropState::PENDING,
            "ERR::PROP_NOT_PENDING::proposal can only be approved while in pending state");

        if (proposal_hash) {
            assert_sha256(prop.packed_transaction.data(), prop.packed_transaction.size(), *proposal_hash);
        }

        approvals apptable(get_self(), dac_id.value);
        auto apps_it = apptable.require_find(proposal_name.value, "ERR::NO_APPROVALS_FOUND::No approvals were found.");
        auto itr     = std::find_if(
            apps_it->requested_approvals.begin(), apps_it->requested_approvals.end(), [&](const approval &a) {
                return a.level == level;
            });
        check(itr != apps_it->requested_approvals.end(), "approval is not on the list of requested approvals");

        apptable.modify(apps_it, same_payer, [&](auto &a) {
            a.provided_approvals.push_back(approval{level, current_time_point()});
            a.requested_approvals.erase(itr);
        });

        transaction_header trx_header = get_trx_header(prop.packed_transaction.data(), prop.packed_transaction.size());

        if (prop.earliest_exec_time.has_value()) {
            if (!prop.earliest_exec_time->has_value()) {
                auto table_op = [](auto &&, auto &&) {};
                if (trx_is_authorized(get_approvals_and_adjust_table(get_self(), proposal_name, table_op, dac_id),
                        prop.packed_transaction)) {
                    proptable.modify(prop, same_payer, [&](auto &p) {
                        p.earliest_exec_time = std::optional<time_point>{
                            current_time_point() + eosio::seconds(trx_header.delay_sec.value)};
                    });
                }
            }
        } else {
            check(trx_header.delay_sec.value == 0,
                "old proposals are not allowed to have non-zero `delay_sec`; cancel and retry");
        }
        auto prop_itr = proptable.iterator_to(prop);
        proptable.modify(prop_itr, same_payer, [&](proposal &p) {
            p.modified_date = current_time_point();
        });
    }

    void multisig::unapprove(name proposal_name, permission_level level, name dac_id) {
        if (level.permission == "eosio.code"_n) {
            check(get_sender() == level.actor, "wrong contract sent `unapprove` action for eosio.code permmission");
        } else {
            require_auth(level);
        }

        approvals apptable(get_self(), dac_id.value);
        auto apps_it = apptable.require_find(proposal_name.value, "ERR::NO_APPROVALS_FOUND::No approvals were found.");
        auto itr     = std::find_if(
            apps_it->provided_approvals.begin(), apps_it->provided_approvals.end(), [&](const approval &a) {
                return a.level == level;
            });
        check(itr != apps_it->provided_approvals.end(), "no approval previously granted");
        apptable.modify(apps_it, same_payer, [&](auto &a) {
            a.requested_approvals.push_back(approval{level, current_time_point()});
            a.provided_approvals.erase(itr);
        });

        proposals proptable(get_self(), dac_id.value);
        auto &    prop = proptable.get(proposal_name.value, "proposal not found");
        check(prop.state == PropState::PENDING,
            "ERR::PROP_NOT_PENDING::proposal can only be changed while in pending state.");

        if (prop.earliest_exec_time.has_value()) {
            if (prop.earliest_exec_time->has_value()) {
                auto table_op = [](auto &&, auto &&) {};
                if (!trx_is_authorized(get_approvals_and_adjust_table(get_self(), proposal_name, table_op, dac_id),
                        prop.packed_transaction)) {
                    proptable.modify(prop, same_payer, [&](auto &p) {
                        p.earliest_exec_time = std::optional<time_point>{};
                    });
                }
            }
        } else {
            transaction_header trx_header =
                get_trx_header(prop.packed_transaction.data(), prop.packed_transaction.size());
            check(trx_header.delay_sec.value == 0,
                "old proposals are not allowed to have non-zero `delay_sec`; cancel and retry");
        }
        auto prop_itr = proptable.iterator_to(prop);
        proptable.modify(prop_itr, same_payer, [&](proposal &p) {
            p.modified_date = current_time_point();
        });
    }

    void multisig::cancel(name proposal_name, name canceler, name dac_id) {
        require_auth(canceler);

        proposals proptable(get_self(), dac_id.value);
        auto &    prop = proptable.get(proposal_name.value, "proposal not found");

        if (canceler != prop.proposer) {
            check(unpack<transaction_header>(prop.packed_transaction).expiration <
                      eosio::time_point_sec(current_time_point()),
                "cannot cancel until expiration");
        }
        check(prop.state == PropState::PENDING,
            "ERR::PROP_NOT_PENDING::proposal can only be changed while in pending state.");

        auto prop_itr = proptable.iterator_to(prop);
        proptable.modify(prop_itr, same_payer, [&](proposal &p) {
            p.modified_date = current_time_point();
            p.state         = PropState::CANCELLED;
        });

        // proptable.erase(prop);

        // approvals apptable(get_self(), dac_id.value);
        // auto apps_it = apptable.require_find(proposal_name.value, "ERR::NO_APPROVALS_FOUND::No approvals were
        // found."); apptable.erase(apps_it);
    }

    void multisig::exec(name proposal_name, name executer, name dac_id) {
        require_auth(executer);

        proposals proptable(get_self(), dac_id.value);
        auto &    prop = proptable.get(proposal_name.value, "proposal not found");
        check(prop.state == PropState::PENDING,
            "ERR::PROP_EXEC_NOT_PENDING::The same proposal cannot be executed mulitple times.");

        datastream<const char *> ds = {prop.packed_transaction.data(), prop.packed_transaction.size()};
        transaction_header       trx_header;
        std::vector<action>      context_free_actions;
        std::vector<action>      actions;
        ds >> trx_header;
        check(trx_header.expiration >= eosio::time_point_sec(current_time_point()), "transaction expired");
        ds >> context_free_actions;
        check(context_free_actions.empty(), "not allowed to `exec` a transaction with context-free actions");
        ds >> actions;

        auto table_op = [](auto &&, auto &&) {};

        bool ok = trx_is_authorized(
            get_approvals_and_adjust_table(get_self(), proposal_name, table_op, dac_id), prop.packed_transaction);
        check(ok, "transaction authorization failed");

        if (prop.earliest_exec_time.has_value() && prop.earliest_exec_time->has_value()) {
            check(**prop.earliest_exec_time <= current_time_point(), "too early to execute");
        } else {
            check(trx_header.delay_sec.value == 0,
                "old proposals are not allowed to have non-zero `delay_sec`; cancel and retry");
        }

        for (const auto &act : actions) {
            act.send();
        }

        auto prop_itr = proptable.iterator_to(prop);
        proptable.modify(prop_itr, same_payer, [&](proposal &p) {
            p.modified_date = current_time_point();
            p.state         = PropState::EXECUTED;
        });
    }

    void multisig::cleanup(name proposal_name, name dac_id) {
        proposals proptable(get_self(), dac_id.value);
        auto &    prop = proptable.get(proposal_name.value, "proposal not found");
        check(prop.state != PropState::PENDING,
            "ERR::PROPOSAL_CLEANUP_STILL_PENDING::proposal cannot be cleared before being executed or cancelled.");

        approvals apptable(get_self(), dac_id.value);
        auto apps_it = apptable.require_find(proposal_name.value, "ERR::NO_APPROVALS_FOUND::No approvals were found.");
        apptable.erase(apps_it);
        proptable.erase(prop);
    }

    void multisig::invalidate(name account, name dac_id) {
        require_auth(account);
        invalidations inv_table(get_self(), dac_id.value);
        auto          it = inv_table.find(account.value);
        if (it == inv_table.end()) {
            inv_table.emplace(account, [&](auto &i) {
                i.account                = account;
                i.last_invalidation_time = current_time_point();
            });
        } else {
            inv_table.modify(it, account, [&](auto &i) {
                i.last_invalidation_time = current_time_point();
            });
        }
    }

    transaction_header get_trx_header(const char *ptr, size_t sz) {
        datastream<const char *> ds = {ptr, sz};
        transaction_header       trx_header;
        ds >> trx_header;
        return trx_header;
    }

    bool trx_is_authorized(const std::vector<permission_level> &approvals, const std::vector<char> &packed_trx) {
        auto packed_approvals = pack(approvals);
        return check_transaction_authorization(
            packed_trx.data(), packed_trx.size(), (const char *)0, 0, packed_approvals.data(), packed_approvals.size());
    }

} // namespace eosio