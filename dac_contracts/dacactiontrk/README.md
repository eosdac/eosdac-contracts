# Extension to help DACs ensure engagement from custodians through DAC actions

The intention of this contract is to protect against custodian apathy or disengagement and allow another custodian to enter in the elected board of custodians. Think of it as proof of engagement.

This contract would track engagement as a score for each custodian.

A table entry would be created for each custodian when they are first elected and they get given a starting score eg. 50 points.

With each action of engagement in the DAC such as voting for proposals or arbitary future actions deemed to be engaging they would get a further point.

On each new period everyone would have their balance reduced by fixed amount eg. 10 points or whatever is regarded as a satisfactory level of engagement for a period from a custodian. If their points fall to 0 they would omitted from re-election for a configured number of penalty periods.

Their stake should remain locked during this penalty time to reduce easily moving to a different account for re-election. All the numbers mentioned above should be configurable within the contract as settings to allow different settings for each DAC to tune for the nature of their engagement.

This functionality could be useful for the EOSDAC DAC cluster but also be applicable as an approach for the EOS WPS to ensure and measure participation from BPs in the wider EOS ecosystem with a possible objective way to remove inactive block producers.
Of course there will be ways to game the system while we do not require KYCd accounts to participate but this could at least create friction to apathy and laziness which could lead to the easy option for the custodians to participate rather than not participate.

The `dacdirectory` contract should be configured by adding the account where this contract is installed in the
`ACTION_TRACK` (11) type account. If not set for a DAC then the action tracking is ignored for that particular DAC.

## trackevent (name: custodian, uint8: score, name: dacId)

This should be called as an inline action from various actions that should be positively tracked within the running of a DAC.
When an action occurs in one of the DAC contracts this action would be called with custodian's account name and points that would attach a value to that action. The points are then added to that custodian scrore

## periodend(vector<name> currentCustodians, name: dacId)

At the end of each period this action would be called to subtract points from all the current elected custodians in preparation for the new period. If a custodian has been active throughout the period then this should still leave them with a positive score. If they have been inactive their score will fall to 0 and their custodian account will be locked for a configured number of periods. This action should also decrement period counts for locked out custodians before being eligable for re-election. This should be called at the _start_ of the `newperiod` actions as an inline action to prepare for selecting the next set of candidates.

## periodstart(vector<name> newCustodians, name: dacId)

At the beginning of a new period this action would configure starting scores for newly elected custodians to each have a starting score. Existing custodians should have action taken as their score should carry over from previous DAC periods.
This should be called at the _end_ of the `newperiod` actions as an inline action to configure a valid starting score for each new custodian.

## setConfig(config, name: dacId)

Update settings specific for the DAC to suit level of involvement and expected level of engagement.
Fields include:
uint16 startingScore - The level given to a new custodian when newly elected in.
uint16 newperiodAdjustment - The amount of points subtracted from each custodian at periodend.
uint8 numberOmittedPeriods - When a custodian hits a 0 balance this is the number of periods before they are ommited from being re-elected.
