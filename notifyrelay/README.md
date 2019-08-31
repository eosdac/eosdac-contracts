# Notifications Relay Contract

Notifications sent from `daccustodian` are sent with the authority of that contract which means that contracts being notified can use RAM owned by `daccustodian`.  The solution is to use a relay account to send the notifications from.

This contract is designed to receive requests to send notifications from a trusted contract.  It will look up the contracts to notify in the `dacdirectory` contract.

This contract **must** be installed in an account with minimal free RAM, this prevents RAM stealing because the account has none free.

## Configuring notifications

Notifications must be configured in the `daccustodian` and the `dacdirectory` entry.

### DAC Directory setup

The account that the relay is installed into must be set in the accounts map of the `dacdirectory` contract with the `type` 8.

`cleos push action dacdirectory regaccount '["dacid", "relayaccount", 8]' -p directoryowner`
 
### Custodian setup

Register notifications using the `regnotify` action.

`cleos push action daccustodian regnotify '["type", "contract", "action", "dacid"]' -p daccustodian`

The only types currently allowed are `vote` and `newperiod`.  See the `daccustodian` shared header file for information on the data sent in a notification.
