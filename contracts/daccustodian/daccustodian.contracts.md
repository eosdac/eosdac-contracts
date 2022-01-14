<h1 class="contract">stprofile</h1>

---

spec_version: "0.2.0"
title: Update Profile
summary: 'Update profile for account {{ nowrap cand }} for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

Register a profile on the account {{ cand }}, all data submitted will be visible on the blockchain.

DO NOT SUBMIT PERSONAL DATA HERE

<h1 class="contract">firecust</h1>

---

spec_version: "0.2.0"
title: Fire Custodian
summary: 'Fire custodian {{ nowrap cand }} for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

This action will fire the custodian {{ cand }} and remove them from the list of candidates.

<h1 class="contract">resigncust</h1>

---

spec_version: "0.2.0"
title: Resign as a Custodian
summary: 'Resign custodian {{ nowrap cand }} for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

This action will resign the custodian account {{ cand }}. This account will be removed from the list of candidates.

<h1 class="contract">firecand</h1>

---

spec_version: "0.2.0"
title: Remove Candidate
summary: 'Remove candidate {{ nowrap cand }} for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

This action will remove the custodian account {{ cand }}. This account will be removed from the list of candidates.

{{#if lockupStake}}Lockup stake will be eligible to be withdrawn.{{/if}}

<h1 class="contract">unstakee</h1>

---

spec_version: "0.2.0"
title: Unstake Candidate Deposit
summary: 'Unstake {{ nowrap cand }} for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

Unstake custodian stake.

Custodian stake will be returned after calling this action, subject to the candidate having passed the lockup period.

<h1 class="contract">updateconfig</h1>

---

spec_version: "0.2.0"
title: Update DAC Config
summary: 'Update config for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

Update the DAC config for {{ dac_id }} to the provided configuration.

<h1 class="contract">nominatecand</h1>

---

spec_version: "0.2.0"
title: Register as a Candidate
summary: 'Register {{ nowrap cand }} as a candidate for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

Register {{ nowrap cand }} as a candidate for {{ dac_id }}, I request to be paid {{ nowrap requestedpay }}

<h1 class="contract">withdrawcand</h1>

---

spec_version: "0.2.0"
title: Unregister as a Candidate
summary: 'Unregister {{ nowrap cand }} as a candidate for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

Unregister {{ nowrap cand }} as a candidate for {{ dac_id }}. {{ nowrap cand }} will be removed from the list of active candidates.

<h1 class="contract">updatereqpay</h1>

---

spec_version: "0.2.0"
title: Update Requested Pay
summary: 'Update requested pay for {{ nowrap cand }} to {{ nowrap requestedpay }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

Change requested pay for {{ nowrap cand }} to {{ nowrap requestedpay }}, this change will be part of the calculation at the next election period.

<h1 class="contract">votecust</h1>

---

spec_version: "0.2.0"
title: Vote for Custodian
summary: 'Vote for custodians with account {{ nowrap voter }} to {{ nowrap requestedpay }} for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

This action is casting a vote for the following candidates:

{{#each newvotes}}
**{{ this }}**
{{/each}}

Any previous votes will be removed by these

<h1 class="contract">newperiod</h1>

---

spec_version: "0.2.0"
title: New Period
summary: 'Start a new election period for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

The intent of this action is to signal the end of one election period and commence the next. It performs several actions after the following conditions are met:

- The action is not called before the period should have ended
- Enough voter value has participated to trigger the initial running of the DAC
- After the Dac has started enough voter value has continued engagement with the dac voting process.

1. Calculate the mean `requestedpay` of all the currently elected custodians.
2. Distribute the median pay amount to all the currently elected custodians. This is achieved by adding a record to the `pendingpay` table with the custodian and the amount payable in preparation for an authorised action to `claimpay`.
3. Captures the highest voted candidates to set them as the custodians for the next period based on the accumulated vote weight.
4. Set the permissions for the elected custodians so they have sufficient permission to run the dac according to the constitution and technical permissions design.
5. Set the time for the beginning of the next period to mark the reset anniversary for the dac.

{{#if message}}A message of "{{ message }}" will be recorded on the blockchain.{{/if}}

<h1 class="contract">claimpay</h1>

---

spec_version: "0.2.0"
title: Claim Custodian Pay
summary: 'Claim custodian pay with ID {{ payid }} for DAC {{ dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

Claim custodian pay with ID {{ payid }}, the account calling this action must be the same account that the pay claim is for.

Payment will be delayed based on the configuration of the DAC.

<h1 class="contract">rejectcuspay</h1>

---

spec_version: "0.2.0"
title: Reject Custodian Pay
summary: 'Reject custodian pay with ID {{ payid }} for DAC {{ dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd

---

This action will REJECT the pay claim with ID {{ payid }} for DAC {{ dac_id }}.
