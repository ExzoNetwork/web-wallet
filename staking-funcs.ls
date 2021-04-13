require! {
    \prelude-ls : { map, split, filter, find, foldl, drop, take, sum, unique, pairs-to-obj }
    \./math.ls : { div, times, plus, minus }
    \./round-human.ls
}
SIMULATION_COUNT = 14600
EPOCHS_PER_YEAR = 1460
VALIDATOR_COUNT = 19
as-callback = (p, cb)->
    p.catch (err) -> cb err
    p.then (data)->
        cb null, data
get-stakes-from-stakes-accounts = (store, item)->
    found = store.staking.accounts
        |> filter (it)->
            stake-data = it?account?data?parsed?info?stake?delegation
            return no if not stake-data?
            +stake-data.activationEpoch < +stake-data.deactivationEpoch and stake-data?voter is item.key
    stakes =
        | found.length > 0 =>
            found |> map (-> {seed: it.seed, item: it, stake: it.account?data?parsed?info?stake?delegation?stake})
        | _ => []
    return stakes
fill-pools = ({ store, web3t, on-progress, on-finish }, [item, ...rest]) ->
    if not item? then
        store.staking.all-pools-loaded = yes
        store.staking.pools-are-loading = no
        return on-finish null, []
    if (([\validators, \info, \account_details, \pool_details].index-of(store.current.page)) is -1) then
        store.staking.all-pools-loaded = no
        store.staking.pools-are-loading = no
        return on-finish null, []
    ###############
    ###############
    item.activatedStake = item.activatedStake
    item.balanceRaw = item.activatedStake
    item.address = item.key
    item.stake = item.stake
    item.stake-initial = item.activatedStake
    item.status = "Not delegated"
    item.status = status
    item.commission = item.commission
    item.credits_observed =
        item.epochCredits
            |> map (it)->
                it[1]
            |> foldl plus, 0
    item.delegators = store.staking.delegators[item.votePubkey] ? 0
    stakes = get-stakes-from-stakes-accounts(store, item)
    item.stakes = stakes
    on-progress [item, ...rest] if on-progress?
    on-finish-local = (err, pools) ->
        on-finish err, [item, ...pools]
    on-progress-local = (pools) ->
        on-progress [item, ...pools]
    fill-pools { store, web3t, on-progress: on-progress-local, on-finish: on-finish-local }, rest
query-pools-web3t = (store, web3t, on-progress, on-finish) ->       
    err, validators <- as-callback web3t.velas.NativeStaking.getStakingValidators()
    return on-finish err if err?
    console.log "Got validators" validators
    store.staking.pools-are-loading = yes
    fill-pools { store, web3t, on-progress, on-finish }, validators
query-pools = (store, web3t, on-progress, on-finish) ->
    err <- fill-delegators store, web3t      
    err, pools <- query-pools-web3t store, web3t, on-progress
    return on-finish err if err?
    on-finish err, pools
fill-delegators = (store, web3t, cb)->
    accounts = store.staking.parsedProgramAccounts
    fill-delegator(store, web3t, accounts, cb)
fill-delegator = (store, web3t, [acc, ...accounts], cb)!->
    return cb null if not acc?
    voter             =        acc.account?data?parsed?info?stake?delegation?voter
    activationEpoch   = Number(acc.account?data?parsed?info?stake?delegation?activationEpoch  ? 0)
    deactivationEpoch = Number(acc.account?data?parsed?info?stake?delegation?deactivationEpoch ? 0)
    if (voter and (deactivationEpoch > activationEpoch or activationEpoch is web3t.velas.NativeStaking.max_epoch))  
        store.staking.delegators[voter] = if store.staking.delegators[voter]? then (store.staking.delegators[voter] + 1) else 1
    fill-delegator(store, web3t, accounts, cb)
# Accounts
query-accounts = (store, web3t, on-progress, on-finish) ->
    err, accounts <- query-accounts-web3t store, web3t, on-progress
    return on-finish err if err?
    on-finish err, accounts
query-accounts-web3t = (store, web3t, on-progress, on-finish) ->
    parsedProgramAccounts = store.staking.parsedProgramAccounts
    err, accs <- as-callback web3t.velas.NativeStaking.getOwnStakingAccounts(parsedProgramAccounts) 
    accs = [] if err?  
    console.log "accs" accs 
    return on-finish err if err?
    store.staking.pools-are-loading = yes
    fill-accounts { store, web3t, on-progress, on-finish }, accs
fill-accounts = ({ store, web3t, on-progress, on-finish }, [item, ...rest]) ->
    if not item? then
        store.staking.all-pools-loaded = yes
        store.staking.pools-are-loading = no
        return on-finish null, []
    if (([\validators, \info, \account_details, \pool_details].index-of(store.current.page)) is -1) then
        store.staking.all-pools-loaded = no
        store.staking.pools-are-loading = no
        return on-finish null, []
    rent = item.account?data?parsed?info?meta?rentExemptReserve
    err, seed <- as-callback web3t.velas.NativeStaking.checkSeed(item.pubkey.toBase58())
    item.seed    = seed ? ".."
    item.address = item.pubkey.toBase58()
    item.key     = item.address
    item.rentRaw = rent
    item.balanceRaw = if rent? then (item.account.lamports `minus` rent) else '-'
    item.balance = if rent? then (Math.round((item.account.lamports `minus` rent) `div` (10^9)) `times` 100) `div` 100  else "-"
    item.rent    = if rent? then (rent `div` (10^9)) else "-"
    item.status  = "Not delegated"
    item.validator = null
    item.account = item.account
    if (item.account?data?parsed?info?stake) then
        activationEpoch   = Number(item.account?data?parsed?info?stake.delegation.activationEpoch)
        deactivationEpoch = Number(item.account?data?parsed?info?stake.delegation.deactivationEpoch)
        if (deactivationEpoch > activationEpoch or activationEpoch is web3t.velas.NativeStaking.max_epoch) then
            item.status    = "loading"
            item.validator = item.account?data?parsed?info?stake?delegation?voter
    on-progress [item, ...rest] if on-progress?
    on-finish-local = (err, pools) ->
        on-finish err, [item, ...pools]
    on-progress-local = (pools) ->
        on-progress [item, ...pools]
    fill-accounts { store, web3t, on-progress: on-progress-local, on-finish: on-finish-local }, rest
###################    
convert-accounts-to-view-model = (accounts) ->
    accounts
        |> map -> {
            account: it.account
            address: it.key ? '..'
            key: it.key
            balanceRaw: it.balance ? 0
            balance: if it.balance? then round-human(it.balance) else '..'
            rent: if it.rent? then it.rent else "-"
            lastVote: it.lastVote ? '..'
            seed: it.seed ? '..'
            validator:  it?validator ? ""
            status: it.status ? "Not delegated"
        }
##################
convert-pools-to-view-model = (pools) ->
    pools
        |> map -> {
            address: it.key ? '..',
            balanceRaw: it.activatedStake,
            checked: no,
            stake: if it.stake? then it.stake else '..',
            stake-initial: if it.activatedStake? then parse-float it.activatedStake `div` (10^9) else 0,
            commission: it.commission
            lastVote: if it.lastVote then round-human(it.lastVote) else '..'
            stakers: if it.delegators? then it.delegators else '..',
            is-validator:  (it?stakes? and it.stakes.length isnt 0) ? false,
            status: it.status,
            my-stake: if it?stakes then it.stakes else []
            credits_observed : it.credits_observed
        }
module.exports = { query-pools, query-accounts, convert-accounts-to-view-model, convert-pools-to-view-model }