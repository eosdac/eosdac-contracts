#pragma once

static constexpr eosio::symbol TLM_SYM{"TLM", 4};
#define TLM_TOKEN_CONTRACT_STR "alien.worlds"
static constexpr eosio::name TLM_TOKEN_CONTRACT{TLM_TOKEN_CONTRACT_STR};
static constexpr eosio::name MSIG_CONTRACT{"msig.world"};

#define NFT_CONTRACT_STR "atomicassets"
static constexpr eosio::name NFT_CONTRACT{NFT_CONTRACT_STR};
static constexpr eosio::name NFT_COLLECTION{"alien.worlds"};
static constexpr eosio::name BUDGET_SCHEMA{"budget"};

#define DACDIRECTORY_CONTRACT_STR "dacdirectory"
static constexpr eosio::name DACDIRECTORY_CONTRACT{DACDIRECTORY_CONTRACT_STR};

static constexpr uint32_t MINUTES{60};
static constexpr uint32_t HOURS{60 * MINUTES};
static constexpr uint32_t DAYS{24 * HOURS};
// TODO: Fill in final value for SECONDS_TO_DOUBLE
static constexpr uint32_t SECONDS_TO_DOUBLE{30 * DAYS};