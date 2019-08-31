#include "notifyrelay.hpp"

using namespace eosdac;

void notifyrelay::notify(name type, const std::vector<char>& data, name dac_id){
    // Will fail if there is no dac directory
    // TODO : custodian account has to be trusted so this must be hard coded in with a define
    dacdir::dac dac = dacdir::dac_for_id(dac_id);

    auto cust_account = dac.account_for_type(dacdir::CUSTODIAN);
    require_auth(cust_account);

    notifys_table notifys(cust_account, dac_id.value);

    auto by_action = notifys.get_index<"bytype"_n>();
    auto n = by_action.lower_bound(type.value);

    while (n->type == type){
        action(permission_level{get_self(), "active"_n},
               n->contract, n->action,
               std::make_tuple(data, dac_id))
                .send();

        n++;
    }
}
