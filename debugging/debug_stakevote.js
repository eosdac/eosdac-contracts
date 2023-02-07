const { TableFetcher, BatchRun } = require('eosio-helpers');
const _ = require('lodash');

const ENDPOINT = 'https://wax.greymass.com';
WEIGHT_TABLE = 'weights';
STAKEVOTE_CONTRACT = 'stkvt.worlds';
DAO_CONTRACT = 'dao.worlds';
TOKEN_CONTRACT = 'token.worlds';
MAX = 2 ** 32;
CACHE_FILE = 'tables_stakevote.json';
let tables = {}; // dac_id -> { stakes, weights, config, stakeconfig }
let virtual_weights = {}; // dac_id -> { voter -> {voter, weight, weight_quorum } }
let differences = {}; // dac_id ->  { ours, theirs }

function save() {
  const json = JSON.stringify(tables, null, 2);
  const fs = require('fs');
  fs.writeFileSync(CACHE_FILE, json);
}
function load() {
  const fs = require('fs');
  const json = fs.readFileSync(CACHE_FILE);
  tables = JSON.parse(json);
}
async function main() {
  // if tables.json exists, load from file
  if (require('fs').existsSync(CACHE_FILE)) {
    load();
  } else {
    await fetch_all_tables();
    save();
  }
  for (const dac_id of Object.keys(tables)) {
    // if (dac_id !== 'nerix') continue;
    await handle_dac(dac_id);
    await compare_to_chain(dac_id);
  }
}

async function compare_to_chain(dac_id) {
  if (!differences[dac_id]) {
    differences[dac_id] = [];
  }
  for (const theirs of tables[dac_id].weights) {
    // console.log('weight', weight);
    const ours = virtual_weights[dac_id][theirs.voter];
    // console.log('ours', ours);

    differences[dac_id].push({ ours, theirs });
    //   console.log(
    //     `ours: ${JSON.stringify(ours)} theirs: ${JSON.stringify(weight)}`
    //   );
  }

  // Add MSE to each difference
  for (const difference of differences[dac_id]) {
    const { ours, theirs } = difference;
    difference.mse =
      Math.pow(ours.weight - theirs.weight, 2) +
      Math.pow(ours.weight_quorum - theirs.weight_quorum, 2);
  }

  // filter out differences with MSE of 0
  differences[dac_id] = differences[dac_id].filter((x) => x.mse > 0);

  // sort by MSE of both weights and weight_quorum (descending) using lodash
  differences[dac_id] = _.orderBy(differences[dac_id], ['mse'], ['desc']);

  console.log(
    `dac_id: ${dac_id}\ndifferences : ${JSON.stringify(
      differences[dac_id],
      null,
      2
    )}`
  );
  // print length of differences of total weights
  console.log(
    `dac_id ${dac_id}: ${differences[dac_id].length}/${tables[dac_id].weights.length} weights differ`
  );
}

async function handle_dac(dac_id) {
  const stakes = tables[dac_id].stakes;
  for (const stake of stakes) {
    await process_stake(dac_id, stake);
  }
  //   console.log(JSON.stringify(virtual_weights, null, 2));
}

async function process_stake(dac_id, stake) {
  const unstake_delay = await get_unstake_delay(dac_id, stake);
  //   console.log('unstake_delay', unstake_delay);
  const account = stake.account;
  const { weight } = tables[dac_id].weights.find((x) => x.voter === account);
  //   console.log('weight', weight);
  const weight_delta_quorum = amount(stake.stake);
  //   console.log('weight_delta_quorum', weight_delta_quorum);
  //         const auto stake_delta    = S{(stake->stake).amount}.to<double>();
  const stake_delta = stake.stake;
  // const auto weight_delta_s = stake_delta * (S{1.0} + unstake_delay * time_multiplier / max_stake_time);
  const { time_multiplier } = tables[dac_id].stakevoteconfig[0];
  //   console.log({ time_multiplier });
  const { max_stake_time } = tables[dac_id].stakeconfig[0];
  //   console.log({ unstake_delay, time_multiplier, max_stake_time, stake_delta });
  const weight_delta = Math.floor(
    amount(stake_delta) *
      (1.0 + (unstake_delay * time_multiplier) / max_stake_time)
  );
  //   console.log({ weight_delta });

  upsert(dac_id, account, weight_delta, weight_delta_quorum);
}

function upsert(dac_id, voter, weight, weight_quorum) {
  if (!virtual_weights[dac_id]) {
    virtual_weights[dac_id] = {};
  }
  virtual_weights[dac_id][voter] = {
    voter,
    weight,
    weight_quorum,
  };
}
function amount(x) {
  return Math.round(parseFloat(x) * 10000);
}

async function get_unstake_delay(dac_id, stake) {
  const staketime = tables[dac_id].staketime.find(
    (x) => x.account === stake.account
  );
  if (staketime) {
    return staketime.delay;
  } else {
    const [{ min_stake_time, max_stake_time }] = tables[dac_id].stakeconfig;
    return min_stake_time;
  }
}

async function fetch_all_tables() {
  const dacs = await TableFetcher({
    codeContract: 'index.worlds',
    batch_size: 100,
    endpoint: ENDPOINT,
    limit: MAX,
    scope: 'index.worlds',
    table: 'dacs',
  });
  for (const { dac_id } of dacs) {
    console.log('fetching tables for dac_id: ', dac_id);

    const stakeconfig = await TableFetcher({
      codeContract: TOKEN_CONTRACT,
      batch_size: 1,
      endpoint: ENDPOINT,
      limit: MAX,
      scope: dac_id,
      table: 'stakeconfig',
    });
    const stakevoteconfig = await TableFetcher({
      codeContract: STAKEVOTE_CONTRACT,
      batch_size: 1,
      endpoint: ENDPOINT,
      limit: MAX,
      scope: dac_id,
      table: 'config',
    });
    // console.log('stakevoteconfig: ', stakevoteconfig);
    const stakes = await TableFetcher({
      codeContract: TOKEN_CONTRACT,
      batch_size: 100,
      endpoint: ENDPOINT,
      limit: MAX,
      scope: dac_id,
      table: 'stakes',
    });
    const weights = await TableFetcher({
      codeContract: STAKEVOTE_CONTRACT,
      batch_size: 100,
      endpoint: ENDPOINT,
      limit: MAX,
      scope: dac_id,
      table: WEIGHT_TABLE,
    });
    const staketime = await TableFetcher({
      codeContract: TOKEN_CONTRACT,
      batch_size: 100,
      endpoint: ENDPOINT,
      limit: MAX,
      scope: dac_id,
      table: 'staketime',
    });

    tables[dac_id] = {
      stakes,
      weights,
      stakevoteconfig,
      stakeconfig,
      staketime,
      dacs,
    };
  }
}
main();
