<h1 class="contract">close</h1>

---
spec_version: "0.2.0"
title: Close Token Balance
summary: 'Close {{nowrap owner}}’s zero quantity balance'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

{{owner}} agrees to close their zero quantity balance for the {{symbol_to_symbol_code symbol}} token.

RAM will be refunded to the RAM payer of the {{symbol_to_symbol_code symbol}} token balance for {{owner}}.

<h1 class="contract">create</h1>

---
spec_version: "0.2.0"
title: Create New Token
summary: 'Create a new token'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

{{$action.account}} agrees to create a new token with symbol {{asset_to_symbol_code maximum_supply}} to be managed by {{issuer}}.

This action will not result any any tokens being issued into circulation.

{{issuer}} will be allowed to issue tokens into circulation, up to a maximum supply of {{maximum_supply}}.

RAM will deducted from {{$action.account}}’s resources to create the necessary records.

<h1 class="contract">issue</h1>

---
spec_version: "0.2.0"
title: Issue Tokens into Circulation
summary: 'Issue {{nowrap quantity}} into circulation and transfer into {{nowrap to}}’s account'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

The token manager agrees to issue {{quantity}} into circulation, and transfer it into {{to}}’s account.

{{#if memo}}There is a memo attached to the transfer stating:
{{memo}}
{{/if}}

If {{to}} does not have a balance for {{asset_to_symbol_code quantity}}, or the token manager does not have a balance for {{asset_to_symbol_code quantity}}, the token manager will be designated as the RAM payer of the {{asset_to_symbol_code quantity}} token balance for {{to}}. As a result, RAM will be deducted from the token manager’s resources to create the necessary records.

This action does not allow the total quantity to exceed the max allowed supply of the token.

<h1 class="contract">open</h1>

---
spec_version: "0.2.0"
title: Open Token Balance
summary: 'Open a zero quantity balance for {{nowrap owner}}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

{{ram_payer}} agrees to establish a zero quantity balance for {{owner}} for the {{symbol_to_symbol_code symbol}} token.

If {{owner}} does not have a balance for {{symbol_to_symbol_code symbol}}, {{ram_payer}} will be designated as the RAM payer of the {{symbol_to_symbol_code symbol}} token balance for {{owner}}. As a result, RAM will be deducted from {{ram_payer}}’s resources to create the necessary records.


<h1 class="contract">transfer</h1>

---
spec_version: "0.2.0"
title: Transfer Tokens
summary: 'Send {{nowrap quantity}} from {{nowrap from}} to {{nowrap to}}'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

{{from}} agrees to send {{quantity}} to {{to}}.

{{#if memo}}There is a memo attached to the transfer stating:
{{memo}}
{{/if}}

If {{from}} is not already the RAM payer of their {{asset_to_symbol_code quantity}} token balance, {{from}} will be designated as such. As a result, RAM will be deducted from {{from}}’s resources to refund the original RAM payer.

If {{to}} does not have a balance for {{asset_to_symbol_code quantity}}, {{from}} will be designated as the RAM payer of the {{asset_to_symbol_code quantity}} token balance for {{to}}. As a result, RAM will be deducted from {{from}}’s resources to create the necessary records.







<h1 class="contract">unlock</h1>

---
spec_version: "0.2.0"
title: Unlock Tokens
summary: 'Unlocks the {{ asset_to_symbol_code unlock }} token and allows transfers'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

Unlocks the token {{ asset_to_symbol_code unlock }} on this contract so that it can be transferred. This can only be done once to unlock a token and cannot be reversed to lock a token again.


<h1 class="contract">burn</h1>

---
spec_version: "0.2.0"
title: Burn Tokens
summary: 'Will burn (remove from circulation) {{ nowrap quantity }} tokens and deduct them from the supply of the {{ asset_to_symbol_code quantity }} token.'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

The intent of {{ burn }} is to allow a user to burn {{ quantity }} tokens that belong to them.  These tokens will be removed from supply and the balance of {{ nowrap from }} will be reduced by {{ nowrap quantity }}.

**WARNING** You will lose tokens by proceeding, this process cannot be reversed!


<h1 class="contract">
   memberrege
</h1>

---
spec_version: "0.2.0"
title: Register as a Member
summary: 'Register account {{ nowrap sender }} for DAC with ID {{ nowrap dac_id }} and agree to the terms identified by {{ agreedterms }}.'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

Agree to the terms and condition using the hash provided ({{ agreedterms }}).  This hash can only be generated by starting with a valid user agreement.

This action can be called multiple times if the terms and conditions are updated.  You will be registered as a member in the on-chain database.

<h1 class="contract">
   memberunrege
</h1>

---
spec_version: "0.2.0"
title: Unregister as a Member
summary: 'Unregister account {{ nowrap sender }} for DAC with ID {{ nowrap dac_id }}.'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

This action indicates that you no longer agree to the terms and conditions.  Your account will be marked as no longer a member.

<h1 class="contract">
   newmemtermse
</h1>

---
spec_version: "0.2.0"
title: Set new member terms
summary: 'Set new member terms for DAC with ID {{ nowrap dac_id }} to {{ term }} with hash {{ hash }}.'
icon: https://eosdac.io/assets/contracts/generic.png#00da1afc6464028359b3a02ffbdb59e1ea79fa261b5523ce7ac174cc0ef27bbd
---

Updates the member terms to the document at [{{nowrap terms}}]({{nowrap terms}}).  This document has the identifying hash {{ hash }}, this must match or users will not be able to agree.