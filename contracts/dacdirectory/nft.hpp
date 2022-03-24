#pragma once
#include <atomicassets-interface.hpp>

namespace nft {

    inline atomicdata::ATTRIBUTE_MAP get_immutable_data(const atomicassets::assets_s &nft) {
        const auto _schemas = atomicassets::schemas_t(NFT_CONTRACT, NFT_COLLECTION.value);
        const auto format   = _schemas.get(nft.schema_name.value, "Schema not found").format;
        return atomicdata::deserialize(nft.immutable_serialized_data, format);
    }

    template <typename T>
    inline auto get_immutable_attr(const atomicassets::assets_s &nft, const string &attr_name) {
        const auto nft_data = get_immutable_data(nft);
        const auto attr     = nft_data.find(attr_name);
        check(attr != nft_data.end(), "No %s found in NFT with id: %s", attr_name, nft.asset_id);
        return std::get<T>(attr->second);
    }

} // namespace nft