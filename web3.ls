#web3@0.19.1
require! {
    \prelude-ls : { obj-to-pairs, map, pairs-to-obj, each, find, keys }
    \./guid.ls
    \./send-form.ls : { wait-form-result }
    \./math.ls : { div, plus, times }
    \protect
    \./navigate.ls
    \./use-network.ls
    \./api.ls : { get-balance, get-transaction-info }
    \./install-plugin.ls : { build-install, build-uninstall, build-install-by-name, build-quick-install }
    \./refresh-account.ls : { background-refresh-account, set-account }
    \web3 : \Web3
    \./get-record.ls
    \./set-page-theme.ls
    \./mirror.ls
    \./plugin-loader.ls : { get-coins }
    \./velas/velas-api.ls
    \./send-funcs.ls
    \./pages.ls
}
state =
    time: null
titles = <[ name@email.com name.ethnamed.io domain.com ]>
show-cases = (store, [title, ...titles], cb)->
    return cb null if not title?
    store.current.send-to-mask = title
    <- set-timeout _, 1000
    <- show-cases store, titles
    return cb null
build-get-balance = (store, coin)-> (cb)->
    network = coin[store.current.network]
    { wallet } = coin
    get-balance { coin.token, network, wallet.address }, cb
build-unlock = (store, cweb3)-> (cb)->
    return cb null if store.page is \locked
    err, data <- wait-form-result \unlock
    return cb err if err?
    cb null, data
build-send-transaction = (store, cweb3, coin)-> (tx, cb)->
    network = coin[store.current.network]
    return cb "Transaction is required" if typeof! tx isnt \Object
    { to, data, decoded-data, value, gas, amount, gas-price } = tx
    return cb "Recipient (to) is required" if typeof! tx.to isnt \String
    value :=
        | value? => value
        | amount? => amount `times` (10 ^ network.decimals)
        | _ => null
    return cb "Either Value or Amount is required" if typeof! value not in <[ String Number ]>
    #console.log \send , 1
    id = guid!
    { current } = store
    { send } = current
    amount-obtain = \0
    amount-obtain-usd = \0
    amount-send-usd = \0
    amount-send-fee = if network.tx-fee? then network.tx-fee else \0
    amount-send-fee-usd = \0
    propose-escrow = no
    #console.log \send , 2
    amount-send = value `div` (10 ^ network.decimals)
    wallet = store.current.account.wallets |> find (.coin.token is coin.token)
    send <<<< {
        to, data, decoded-data, network, coin, wallet, value, gas, gas-price, id, amount-send,
        amount-obtain, amount-obtain-usd, amount-send-usd,
        amount-send-fee, amount-send-fee-usd, propose-escrow
    }
    #console.log \send , 3
    { send-anyway, change-amount } = send-funcs store, web3t
    <- change-amount store, amount-send, yes
    #console.log \send , 4
    #console.log \before, 1
    #err <- calc-amount-and-fee amount-send, 3
    #console.log \after, err
    #return cb err if err?
    #current.page = \send
    #window.scroll-to 0, 0
    navigate store, cweb3, \send
    #console.log \send , 5
    send-anyway! if tx.to isnt ""
    #console.log \send , 6
    helps = titles ++ [network.mask]
    #show-cases store, helps, ->
    err, data <- wait-form-result id
    return cb err if err?
    cb null, data
get-contract-instance = (web3, abi, addr)->
    | typeof! web3.eth.contract is \Function => web3.eth.contract(abi).at(addr)
    | _ => new web3.eth.Contract(abi, addr)
build-contract = (store, methods, coin)-> (abi)-> at: (address)->
    { send-transaction } = methods
    network = coin[store.current.network]
    web3 = new Web3!
    web3.set-provider(new web3.providers.HttpProvider(network.api.web3-provider))
    web3.eth.send-transaction = ({ value, data, to, gas, gas-price }, cb)->
        send-transaction { to, data, value, gas, gas-price }, cb
    get-contract-instance web3, abi, address
build-network-ethereum = (store, methods, coin)->
    { send-transaction, get-balance, get-address } = methods
    contract = build-contract store, methods, coin
    { send-transaction, get-balance, get-address, contract } 
build-other-networks = (store, methods, coin)->
    { send-transaction, get-balance, get-address } = methods
    contract = ->
        throw "Not Implemented For this network"
    { send-transaction, get-balance, get-address, contract } 
build-network-specific = (store, methods, coin)->
    builder =
        | coin.token in <[ eth ]> => build-network-ethereum
        | _ => build-other-networks
    builder store, methods, coin
build-get-usd-amount = (store, coin)-> (amount, cb)->
    return cb "wallet isnt loaded" if typeof! store.current.account?wallets isnt \Array
    wallet = 
        store.current.account.wallets |> find (.coin.token is coin.token)
    return cb "wallet not found for #{token}" if not wallet?
    return cb "usd rate not found #{token}" if not wallet.usd-rate?
    usd = amount `times` wallet.usd-rate
    cb null, usd
build-get-transaction-receipt = (store, cweb3, coin)->
build-api = (store, cweb3, coin)->
    get-transaction-receipt = build-get-transaction-receipt store, cweb3, coin
    send-transaction = build-send-transaction store, cweb3, coin
    get-balance = build-get-balance store, coin
    get-address = build-get-address store, coin
    get-usd-amount = build-get-usd-amount store, coin
    methods = { get-address, send-transaction, get-balance, get-usd-amount, get-transaction-receipt }
    build-network-specific store, methods, coin
build-use = (web3, store)->  (network)->
    <- use-network web3, store, network
get-apis = (cweb3, store, cb)->
    res =
        store.coins
            |> map -> [it.token, build-api(store, cweb3, it)]
            |> pairs-to-obj
    cb null, res
refresh-apis = (cweb3, store, cb)->
    store.coins |> map (.token) |> each (-> delete cweb3[it])
    err, coins <- get-coins store
    return cb err if err?
    store.coins = coins
    err, apis <- get-apis cweb3, store
    return cb err if err?
    cweb3 <<<< apis
    cb null
setup-refresh-timer = ({ refresh-timer, refresh-balances })->
    return if typeof! refresh-timer isnt \Number
    clear-timeout setup-refresh-timer.timer
    setup-refresh-timer.timer = set-timeout refresh-balances, refresh-timer
build-get-account-name = (cweb3, naming)-> (store, cb)->
    record = get-record store
    err, data <- naming.whois record
    return cb err if err?
    cb null, data
build-get-supported-tokens = (cweb3, store)-> (cb)->
    return cb "wallet isnt loaded" if typeof! store.current.account?wallets isnt \Array
    tokens =
        store.coins
            |> map (.token)
    cb null, tokens
build-get-address = (store, coin)-> (cb)->
    return cb "wallet isnt loaded" if not mirror.account-addresses?
    address = mirror.account-addresses[coin.token]
    return cb "wallet not found for #{coin.token}" if not address?
    cb null, address
module.exports = (store, config)->
    cweb3 = {}
    #velas-web3
    refresh-timer = config?refresh-timer
    use = build-use cweb3, store
    install = build-install cweb3, store
    install-quick = build-quick-install cweb3, store 
    uninstall = build-uninstall cweb3, store
    install-by-name = build-install-by-name cweb3, store
    naming = {}
    get-supported-tokens = build-get-supported-tokens cweb3, store
    get-account-name = build-get-account-name cweb3, naming
    refresh-balances = (cb)->
        setup-refresh-timer { refresh-timer, refresh-balances }
        err <- background-refresh-account cweb3, store
        cb? null
    setup-refresh-timer { refresh-timer, refresh-balances }
    init = (cb)->
        set-account cweb3, store, cb
    refresh-interface = (cb)->
        err <- refresh-apis cweb3, store
        return cb err if err?
        cb null
    refresh-page = (cb)->
        return cb null if store.current.page in  <[ wallets ]>
        page = pages[store.current.page]
        return cb null if not page?
        return cb null if typeof! page.init isnt \Function
        <- page.init { store, web3t }
        return cb null if typeof! page.focus isnt \Function
        <- page.focus { store, web3t }
    refresh = (cb)->
        #return if store.current.refreshing
        err <- refresh-interface
        return cb err if err?
        err <- refresh-balances
        return cb err if err?
        refresh-page cb
    set-theme = (it, cb)->
        return cb "support only dark an light" if it not in <[ dark light monochrome dark_mojave ]>
        store.theme = it
        set-page-theme store, it
        cb null
    set-lang = (it, cb)->
        return cb "support only en, ru" if it not in <[ en ru uk ]>
        store.lang = it
        cb null
    set-preference = (preference)->
        set = (key)->
            return if keys not in <[ disablevlx1 ]>
            store.preference[key] = preference[key] ? store.preference[key]
        store.preference |> keys |> each set
    lock = ->
        navigate store,  , \locked
    unlock = build-unlock store, cweb3
    set-preference config if typeof! config is \Object
    refresh-interface ->
    web3 = new Web3!
    velas = velas-api
    cweb3 <<<< { velas, web3.utils, unlock, set-preference, get-supported-tokens, use, refresh, lock, init, install, uninstall, install-by-name, naming, get-account-name, set-theme, set-lang, install-quick }
    cweb3