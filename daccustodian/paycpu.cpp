
using namespace eosdac;

void daccustodian::paycpu(name dac_id) {
    dacdir::dac dac_inst     = dacdir::dac_for_id(dac_id);
    auto        auth_account = dac_inst.account_for_type(dacdir::AUTH);
    require_auth(auth_account);

    auto     size   = transaction_size();
    char *   buffer = (char *)(512 < size ? malloc(size) : alloca(size));
    uint32_t read   = read_transaction(buffer, size);
    check(size == read, "ERR::READ_TRANSACTION_FAILED::read_transaction failed");

    //    time_point_sec  expiration; 32 bits
    //    uint16_t        ref_block_num;
    //    uint32_t        ref_block_prefix;
    //    unsigned_int    max_net_usage_words = 0UL; /// number of 8 byte words this transaction can serialize into
    //    after compressions uint8_t         max_cpu_usage_ms = 0UL;

    // skip buffer to max_cpu_usage_ms
    buffer += 11;
    uint8_t max_cpu_usage_ms = static_cast<uint8_t>(*buffer);
    print("max_cpu_usage: ", max_cpu_usage_ms, "\n");

    check(max_cpu_usage_ms > 0 && max_cpu_usage_ms <= 5, "MAX CPU not set or above maximum");
}
