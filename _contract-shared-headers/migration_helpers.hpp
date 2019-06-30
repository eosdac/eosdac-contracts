#ifndef MIGRATION_HELPERS_H
#define MIGRATION_HELPERS_H
#include <eosio/eosio.hpp>

const eosio::name NEW_SCOPE = "eosdacio"_n;

using namespace eosio;

template <typename T>
void cleanTable(name code, uint64_t account){
    T db(code, account);
    while(db.begin() != db.end()){
        auto itr = --db.end();
        db.erase(itr);
    }
}

// template <typename T, typename E, typename F>
// void migrate_table(name code, uint16_t batch_size, name source_scope, name destn_scope, void (*mapper)(E&, F&) ) {
//     T source(code, source_scope.value);
//     T destination(code, destn_scope.value);
//     auto lastdest = destination.end();
//     if (lastdest == destination.begin()) {
//         return; // empty table nothing copy
//     }
//     uint64_t src_primary_key = (--lastdest)->primary_key();

//     auto source_itrr = source.find(src_primary_key);
//     source_itrr++;
//     uint16_t batch_counter = 0;

//     while (batch_counter < batch_size && source_itrr != source.end()) {
//         destination.emplace(code, [&](E &e){
//             mapper(e, source_itrr);
//         });
//         ++source_itrr;
//         ++batch_counter;
//     }
// }

#endif