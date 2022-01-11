#ifndef MIGRATION_HELPERS_H
#define MIGRATION_HELPERS_H
#include <eosio/eosio.hpp>

const eosio::name NEW_SCOPE = "eosdac"_n;

using namespace eosio;

template <typename T>
void cleanTable(name code, uint64_t account, const uint32_t batchSize){
    T db(code, account);
    uint32_t counter = 0;
    auto itr = db.begin();
    while(itr != db.end() && counter++ < batchSize) {
        itr = db.erase(itr);
    }
}

#endif
