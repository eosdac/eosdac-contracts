

// delete data from config
ACTION stakevote::migration1(const name dac_id) {
    config_container(get_self(), dac_id.value).remove();
}

#ifdef MIGRATION_STAGE_2
// add data back into config
ACTION stakevote::migration2(const name dac_id) {
    auto config = config_item{100000000};
    config.save(get_self(), dac_id, get_self());
}

#endif