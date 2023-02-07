const { TableFetcher, BatchRun } = require('eosio-helpers');
const _ = require('lodash');
const dayjs = require('dayjs');
const utc = require('dayjs/plugin/utc');
dayjs.extend(utc);

const ENDPOINT = 'https://wax.greymass.com';
WEIGHT_TABLE = 'weights';
STAKEVOTE_CONTRACT = 'stkvt.worlds';
DAO_CONTRACT = 'dao.worlds';
TOKEN_CONTRACT = 'token.worlds';
MAX = 2 ** 32;
CACHE_FILE = 'tables_daccustodian.json';

let tables = {}; // dac_id -> { stakes, weights, config, stakeconfig }
let virtual_candidates = {}; // dac_id -> { candidate_name -> {candidate_name, rank, total_vote_power, number_voters, avg_vote_time_stamp, running_weight_time } }
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
  for (const theirs of tables[dac_id].candidates) {
    // console.log('weight', weight);
    let ours = virtual_candidates[dac_id][theirs.candidate_name];
    theirs.avg_vote_time_stamp = dayjs.utc(theirs.avg_vote_time_stamp).unix();

    if (!ours) {
      ours = {
        candidate_name: theirs.candidate_name,
        total_vote_power: 0,
        number_voters: 0,
        avg_vote_time_stamp: 0,
        running_weight_time: BigInt(0),
      };
    }
    // console.log('ours', ours);
    // console.log('theirs', theirs);

    differences[dac_id].push({ ours, theirs });
    //   console.log(
    //     `ours: ${JSON.stringify(ours)} theirs: ${JSON.stringify(weight)}`
    //   );
  }

  // Add MSE to each difference
  for (const difference of differences[dac_id]) {
    const { ours, theirs } = difference;
    difference.mse =
      Math.pow(ours.total_vote_power - theirs.total_vote_power, 2) +
      Math.pow(ours.number_voters - theirs.number_voters, 2) +
      Math.pow(ours.avg_vote_time_stamp - theirs.avg_vote_time_stamp, 2) +
      Math.pow(
        Number(
          BigInt(ours.running_weight_time) - BigInt(theirs.running_weight_time)
        ),
        2
      );
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
  const votes = tables[dac_id].votes;
  for (const vote of votes) {
    // console.log('vote: ', JSON.stringify(vote, null, 2));
    // break;
    await process_vote(dac_id, vote);
  }

  for (const x of Object.values(virtual_candidates)) {
    for (y of Object.values(x)) {
      y['running_weight_time'] = y['running_weight_time'].toString();
      // console.log('y: ', JSON.stringify(y, null, 2));
    }
    // console.log('x: ', JSON.stringify(x, null, 2));
  }

  // console.log(JSON.stringify(virtual_candidates, null, 2));
}

async function process_vote(dac_id, vote) {
  // let virtual_candidates = {}; // dac_id -> { candidate_name -> {candidate_name, rank, total_vote_power, number_voters, avg_vote_time_stamp, running_weight_time } }
  // console.log('vote: ', JSON.stringify(vote, null, 2));
  // return;
  let {
    voter,
    candidates: candidate_names,
    vote_time_stamp,
    vote_count,
  } = vote;
  for (const cand_name of candidate_names) {
    let vote_time_stamp_str = vote_time_stamp;
    // vote_time_stamp = new Date(vote_time_stamp + 'z'); // add z to make it UTC
    // create dayjs utc date from string
    vote_time_stamp = dayjs.utc(vote_time_stamp_str);

    // console.log({ voter, candidate_names, vote_time_stamp, vote_count });
    if (!virtual_candidates[dac_id]) {
      virtual_candidates[dac_id] = {};
    }

    if (!virtual_candidates[dac_id][cand_name]) {
      virtual_candidates[dac_id][cand_name] = {
        candidate_name: cand_name,
        total_vote_power: 0,
        number_voters: 0,
        avg_vote_time_stamp: 0,
        running_weight_time: BigInt(0),
      };
    }
    let cand = virtual_candidates[dac_id][cand_name];
    const { weight, weight_quorum } = get_vote_weight(dac_id, voter);
    // console.log({ cand_name, weight, weight_quorum });
    // console.log('cand: ', JSON.stringify(cand, null, 2));

    cand.total_vote_power += parseInt(weight);
    cand.number_voters += 1;
    const epoch_timestamp = vote_time_stamp.unix();

    cand.running_weight_time += BigInt(weight) * BigInt(epoch_timestamp);

    cand.avg_vote_time_stamp = calc_avg_vote_time(dac_id, cand);
    // console.log({ weight, vote_time_stamp });
  }
  // console.log('cand 2: ', JSON.stringify(cand, null, 2));

  // upsert(dac_id, voter);
}

function calc_rank(dac_id, cand) {}

function calc_avg_vote_time(dac_id, cand) {
  // console.log('cand.running_weight_time: ', cand.running_weight_time);
  // console.log('cand.total_vote_power: ', cand.total_vote_power);
  if (cand.total_vote_power === 0) return 0;
  const out = cand.running_weight_time / BigInt(cand.total_vote_power);
  // console.log('calc_avg_vote_time: out: ', out);
  return Number(out);
}

function get_vote_weight(dac_id, voter) {
  const x = tables[dac_id].weights.find((x) => x.voter === voter);
  // console.log('get_vote_weight: dac_id: ', dac_id, ' voter: ', voter, 'x: ', x);
  if (x) {
    const { weight, weight_quorum } = x;
    return { weight, weight_quorum };
  } else {
    return { weight: 0, weight_quorum: 0 };
  }
}

// function upsert(dac_id, voter, weight, weight_quorum) {
//   if (!virtual_candidates[dac_id]) {
//     virtual_candidates[dac_id] = {};
//   }
//   virtual_candidates[dac_id][voter] = {
//     voter,
//     rank,
//     total_vote_power,
//     number_voters,
//     avg_vote_time_stamp,
//     running_weight_time,
//   };
// }
function amount(x) {
  return Math.floor(parseFloat(x) * 10000);
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

    const votes = await TableFetcher({
      codeContract: DAO_CONTRACT,
      batch_size: 100,
      endpoint: ENDPOINT,
      limit: MAX,
      scope: dac_id,
      table: 'votes',
    });

    const candidates = await TableFetcher({
      codeContract: DAO_CONTRACT,
      batch_size: 100,
      endpoint: ENDPOINT,
      limit: MAX,
      scope: dac_id,
      table: 'candidates',
    });

    tables[dac_id] = {
      stakes,
      weights,
      stakevoteconfig,
      stakeconfig,
      staketime,
      dacs,
      votes,
      candidates,
    };
  }
}
main();
