
cmake_minimum_required(VERSION 3.5)
project(daccustodian VERSION 1.0.0)

find_package(eosio.cdt)

### Generate the wasm and abi
add_contract( daccustodian daccustodian
        daccustodian.cpp
        external_observable_actions.cpp
        newperiod_components.cpp
        pay_handling.cpp
        migration.cpp
        privatehelpers.cpp
        registering.cpp
        update_member_details.cpp
        )

### add the path to where the ricardian contracts/clauses are found
target_compile_options( daccustodian.wasm PUBLIC -R${CMAKE_CURRENT_SOURCE_DIR} )
