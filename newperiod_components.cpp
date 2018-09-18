
void daccustodian::distributePay() {
    auto idx = registered_candidates.get_index<N(byvotes)>();
    auto it = idx.rbegin();

    //Find the median pay using a temporary vector to hold the requestedpay amounts.
    std::vector<int64_t> reqpays;
    uint16_t custodian_count = 0;
    while (it != idx.rend() && custodian_count < configs().numelected && it->total_votes > 0) {
        reqpays.push_back(it->requestedpay.amount);
        it++;
        custodian_count++;
    }

    // Using nth_element to just sort for the entry we need for the median value.
    size_t mid = reqpays.size() / 2;
    std::nth_element(reqpays.begin(), reqpays.begin() + mid, reqpays.end());

    int64_t medianPay = reqpays[mid];

    asset medianAsset = asset(medianPay, configs().requested_pay_max.symbol);

    custodian_count = 0;
    it = idx.rbegin();
    while (it != idx.rend() && custodian_count < configs().numelected && it->total_votes > 0) {
        pending_pay.emplace(_self, [&](pay &p) {
            p.key = pending_pay.available_primary_key();
            p.receiver = it->candidate_name;
            p.quantity = medianAsset;
            p.memo = "EOSDAC Custodian pay. Thank you.";
        });
        it++;
        custodian_count++;
    }

    print("distribute pay");
}

void daccustodian::assert_period_time() {
    uint32_t timestamp = now();
    uint32_t periodBlockCount = timestamp - _currentState.lastperiodtime;
    eosio_assert(periodBlockCount > configs().periodlength,
                 "New period is being called too soon. Wait until the period has completed.");
    _currentState.lastperiodtime = now();
}

//TODO: This should not be public - Tests need refactoring so this can be hidden.
void daccustodian::allocatecust(bool early_election) {

    eosio::print("Configure custodians for the next period.");

    custodians_table custodians(_self, _self);
    auto byvotes = registered_candidates.get_index<N(byvotesrank)>();
    auto cand_itr = byvotes.begin();

    int32_t electcount = configs().numelected;
    uint8_t currentCustodianCount = 0;

    if (!early_election) {
        eosio::print("Empty the custodians table to get a full set of new custodians based on the current votes.");
        auto cust_itr = custodians.begin();
        while (cust_itr != custodians.end()) {
            const auto &reg_candidate = registered_candidates.get(cust_itr->cust_name, "Corrupt data: Trying to set a lockup delay on candidate leaving office.");
            registered_candidates.modify(reg_candidate, cust_itr->cust_name, [&](candidate &c) {
                eosio::print("Lockup stake for release delay.");
                c.custodian_end_time_stamp = now() + configs().lockup_release_time_delay;
            });
            cust_itr = custodians.erase(cust_itr);
        }
    }

    eosio::print("Select only enough candidates to fill the gaps.");
    for (auto itr = custodians.begin(); itr != custodians.end(); itr++) { ++currentCustodianCount; }

    while (currentCustodianCount < electcount) {
        if (cand_itr == byvotes.end() || cand_itr->total_votes == 0) {
            eosio::print("The pool of eligible candidates has been exhausted");
            return;
        }

        //  If the candidate is inactive or is already a custodian skip to the next one.
        if (!cand_itr->is_active || custodians.find(cand_itr->candidate_name) != custodians.end()) {
            cand_itr++;
        } else {
            custodians.emplace(_self, [&](custodian &c) {
                c.cust_name = cand_itr->candidate_name;
                c.requestedpay = cand_itr->requestedpay;
                c.total_votes = cand_itr->total_votes;
            });

            byvotes.modify(cand_itr, cand_itr->candidate_name, [&](candidate &c) {
                    eosio::print("Lockup stake for release delay.");
                    c.custodian_end_time_stamp = now() + configs().lockup_release_time_delay;
            });

            currentCustodianCount++;
            cand_itr++;
        }
    }
}

void daccustodian::setauths() {

    custodians_table custodians(_self, _self);

    account_name accountToChange = configs().authaccount;

    vector<eosiosystem::permission_level_weight> accounts;

    for (auto it = custodians.begin(); it != custodians.end(); it++) {
        eosiosystem::permission_level_weight account{
                .permission = eosio::permission_level(it->cust_name, N(active)),
                .weight = (uint16_t) 1,
        };
        accounts.push_back(account);
    }

    eosiosystem::authority high_contract_authority{
            .threshold = configs().auth_threshold_high,
            .keys = {},
            .accounts = accounts
    };

    action(permission_level{accountToChange,
                            N(owner)},
           N(eosio), N(updateauth),
           std::make_tuple(
                   accountToChange,
                   N(high),
                   N(owner),
                   high_contract_authority))
            .send();

    eosiosystem::authority medium_contract_authority{
            .threshold = configs().auth_threshold_mid,
            .keys = {},
            .accounts = accounts
    };

    action(permission_level{accountToChange, N(owner)},
           N(eosio), N(updateauth),
           std::make_tuple(
                   accountToChange,
                   N(med),
                   N(owner),
                   medium_contract_authority))
            .send();

    eosiosystem::authority low_contract_authority{
            .threshold = configs().auth_threshold_low,
            .keys = {},
            .accounts = accounts
    };

    action(permission_level{accountToChange, N(owner)},
           N(eosio), N(updateauth),
           std::make_tuple(
                   accountToChange,
                   N(low),
                   N(owner),
                   low_contract_authority))
            .send();
}