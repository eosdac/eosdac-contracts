#pragma once

static constexpr eosio::symbol TLM_SYM{"TLM", 4};
#define TLM_TOKEN_CONTRACT_STR "alien.worlds"
static constexpr eosio::name TLM_TOKEN_CONTRACT{TLM_TOKEN_CONTRACT_STR};
static constexpr eosio::name MSIG_CONTRACT{"msig.world"};

#define NFT_CONTRACT_STR "atomicassets"
static constexpr eosio::name NFT_CONTRACT{NFT_CONTRACT_STR};
static constexpr eosio::name NFT_COLLECTION{"alien.worlds"};
static constexpr eosio::name BUDGET_SCHEMA{"budget"};
static constexpr int32_t BUDGET_TEMPLATE_ID{1};

static constexpr eosio::name DACDIRECTORY_CONTRACT{"dacdirectory"};
