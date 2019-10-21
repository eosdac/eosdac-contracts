import {
  Account,
  AccountManager,
  ContractDeployer,
  assertMissingAuthority
} from 'lamington';
import { Dacproposals } from 'dacproposals';
/*
describe("Dacproposals Contract", function () {
    let contract: Dacproposals;
    let account1: Account;

    before(async function () {
        account1 = await AccountManager.createAccount();
    });

    beforeEach(async function () {
        contract = await ContractDeployer.deploy("dacproposals/dacproposals");
    });

    it("allows the owner to call dothing()", async function () {
        await contract.dothing();
    });

    it("should throw when calling dothing() from another account", async function () {
        await assertMissingAuthority(contract.dothing({ from: account1 }));
    });
});
*/
