

void daccustodian::regnotify(name type, name contract, name action, name dac_id){
    // All notifications are billed to the custodian account so restrict usage
    // Do not use only dac for authentication
    require_auth(get_self());

    notifys_table notifys(get_self(), dac_id.value);

    notifys.emplace(get_self(), [&](notify_item &n){
        n.key = notifys.available_primary_key();
        n.type = type;
        n.contract = contract;
        n.action = action;
    });
}

void daccustodian::unregnotify(uint64_t key, name dac_id){
    require_auth(get_self());

    notifys_table notifys(get_self(), dac_id.value);
    auto existing = notifys.get(key, "ERR::NOTIFY_NOT_FOUND::Notify with this key was not found");

    notifys.erase(existing);
}



// Private helpers

void daccustodian::notifyListeners(name type, vector<char> notify_bytes, name dac_id){
    // send a deferred transaction which will then trigger the notifications via inline action
    // deferred is used to prevent the listeners from causing the action to fail
    // transaction is sent via a relay account with no ram to pervent listeners consuming our ram

    dacdir::dac dac = dacdir::dac_for_id(dac_id);

    auto notify_account = dac.account_for_type(dacdir::NOTIFY_RELAY);

    if (notify_account){
        notifys_table notifys(get_self(), dac_id.value);
        if (notifys.begin() == notifys.end()){
            return;
        }

        transaction trx{};

        trx.actions.emplace_back(
                action(permission_level{get_self(), "notify"_n},
                       notify_account, "notify"_n,
                       std::make_tuple(type, notify_bytes, dac_id)
                ));

        trx.delay_sec = 0;

        checksum256 data_hash = sha256(notify_bytes.data(), notify_bytes.size());
        auto data_array = data_hash.get_array();
        uint128_t dh_int = 0;
        for (uint8_t i = 0; i < 16; i++){
            dh_int |= data_array[i] << i * 8;
        }

        trx.send(dh_int, get_self());
    }
}

void daccustodian::notifyListeners(newperiod_notify &n, name dac_id){
    auto packed_notify = pack(n);
    notifyListeners("newperiod"_n, packed_notify, dac_id);
}

void daccustodian::notifyListeners(vote_notify &n, name dac_id){
    auto packed_notify = pack(n);
    notifyListeners("vote"_n, packed_notify, dac_id);
}
