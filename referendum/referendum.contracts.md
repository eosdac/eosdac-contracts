
<h1 class="contract">updateconfig</h1>

---
spec_version: "0.2.0"
title: Update Referendum Configuration
summary: 'Update referendum configuration for DAC ID {{ nowrap dac_id }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

Update the referendum configuration for DAC ID {{ nowrap dac_id }} using the provided values.


<h1 class="contract">propose</h1>

---
spec_version: "0.2.0"
title: Propose a Referendum
summary: 'Propose a referendum for DAC ID {{ nowrap dac_id }} with title "{{ title }}"'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

This will propose a referendum with title "{{ title }}", there may be a fee to pay for this, depending on the configuration of the DAC.


<h1 class="contract">cancel</h1>

---
spec_version: "0.2.0"
title: Cancel a Referendum
summary: 'Cancel a referendum for DAC ID {{ nowrap dac_id }} with ID "{{ referendum_id }}"'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

Cancel an existing referendum, this will cancel an existing referendum with ID {{ referendum_id }}.  The RAM used will be returned.


<h1 class="contract">vote</h1>

---
spec_version: "0.2.0"
title: Vote in Referendum
summary: 'Vote in referendum for DAC ID {{ nowrap dac_id }} with ID "{{ referendum_id }}"'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

{{ nowrap voter }} will update their vote for referendum {{ referendum_id }}.

<h1 class="contract">exec</h1>

---
spec_version: "0.2.0"
title: Execute a Referendum
summary: 'Execute a referendum for DAC ID {{ nowrap dac_id }} with ID "{{ referendum_id }}"'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

Once a referendum has passed the threshold for acceptance, this action will execute it.

Depending on the type of the referendium, this will have a different action.

**Binding** : This will execute the action provided in the referendum.

**Semi-binding** : This will propose a multisig for the custodians to review.

**Opinion** : Nothing will be done.


<h1 class="contract">refund</h1>

---
spec_version: "0.2.0"
title: Refund Referendum Deposit
summary: 'Refund referendum deposit for {{ nowrap account }}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

Account {{ account }} will be refunded any existing referendum deposit which is in the contract.
