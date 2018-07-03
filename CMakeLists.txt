file(GLOB ABI_FILES "*.abi")
configure_file("${ABI_FILES}" "${CMAKE_CURRENT_BINARY_DIR}" COPYONLY)
# Change "daccustodian" with the name of the folder containing your smart contracts
add_wast_executable(TARGET daccustodian
INCLUDE_FOLDERS "${STANDARD_INCLUDE_FOLDERS}"
LIBRARIES libc libc++ eosiolib
DESTINATION_FOLDER ${CMAKE_CURRENT_BINARY_DIR}
)