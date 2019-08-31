
#include "../_contract-shared-headers/daccustodian_shared.hpp"
#include "../_contract-shared-headers/dacdirectory_shared.hpp"


namespace eosdac {
    CONTRACT notifyrelay: public contract {
        private:

        public:
            using contract::contract;

            ACTION notify(name type, const std::vector<char>& data, name dac_id);
    };
}

