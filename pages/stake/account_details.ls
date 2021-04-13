require! {
    \react
    \react-dom
    \../../navigate.ls
    \../../get-primary-info.ls
    \../../web3.ls
    \bignumber.js
    \../../get-lang.ls
    \../../history-funcs.ls
    \../../staking/funcs.ls : { query-pools }
    \../icon.ls
    \prelude-ls : { map, split, filter, find, foldl, sort-by, unique, head, each }
    \../../math.ls : { div, times, plus, minus }
    \../../velas/velas-node-template.ls
    \../../../web3t/providers/deps.js : { hdkey, bip39 }
    \md5
    \../../menu-funcs.ls
    \btoa
    \safe-buffer : { Buffer }
    \../../copied-inform.ls
    \../../copy.ls
    \../../round5.ls
    \../../../web3t/addresses.js : { ethToVlx, vlxToEth }
    \../switch-account.ls
    \../../round-human.ls
    \../../round-number.ls
    \../../icons.ls
    \../placeholder.ls
    \../epoch.ls
    \../confirmation.ls : { alert, notify, confirm }
    \../../components/button.ls
    \../../components/address-holder.ls
    \../alert-txn.ls
    \../../components/amount-field.ls
    \../../seed.ls : seedmem
    \../../components/burger.ls
}
.staking
    @import scheme
    position: relative
    display: block
    width: auto
    margin-left: $left-margin
    top: 0
    height: auto
    min-height: 100vh
    padding-top: 5%
    box-sizing: border-box
    padding: 0px
    background: transparent
    .usd-amount
        opacity: 0.65
        font-size: 10px
        margin-left: 10px
    .loader
        svg
            width: 12px
            cursor: pointer
        &.spin > svg
            @keyframes spin
                from
                    transform: rotate(0deg)
                to
                    transform: rotate(360deg)
            animation-name: spin
            animation-duration: 4000ms
            animation-iteration-count: infinite
            animation-timing-function: linear
        &.disabled
            opacity: 0.3
    .icon-right
        height: 12px
        top: 2px
        position: relative
    .pad
        padding: 0 5px
    .pad-bottom
        padding-bottom: 5px
    @media(max-width:$ipad)
        width: 100%
        margin: 0
    .float-left
        float: left
    .float-right
        float: right
    span.color
        color: #cc8b1a
        font-weight: bold
    .staking-content
        overflow: hidden
        background: transparent
        width: 100%
        border-radius: 0px
        position: relative
        box-sizing: border-box
        .claim-table
            max-height: 100px
            width: 300px
            overflow-y: auto
            background: rgb(90, 26, 154)
            @media(max-width:800px)
                margin: 15px auto
            tbody
                background: rgb(45, 15, 85)
            table
                width: 100%
                tr
                    padding: 0
                    margin: 0
                    td
                        width: 33%
                        &:first-child
                            text-align: center
        .left-proxy, .right-proxy
            width: 15px
            height: 16px
            line-height: 10px
            display: inline-block
            color: white
            padding: 9px
            border-radius: 0px
            cursor: pointer
            vertical-align: top
            text-align: center
        .form-group
            text-align: center
            padding-top: 0px
            input, textarea
                margin: 5px 0
                outline: none
            .section
                border-bottom: 1px solid rgba(240, 237, 237, 0.16)
                padding: 20px 20px
                display: flex
                .chosen-account
                    .buttons
                        text-align: left
                        @media(max-width:800px)
                            text-align: center
                    span
                        @media (max-width: 800px)
                            font-size: 14px
                    .check
                        width: 15px
                        height: 15px
                        margin-left: 10px
                        vertical-align: middle
                        animation: pulse_check 1s linear
                        transform-origin: 50% 50%
                    @keyframes pulse_check
                        0%
                            transform: scale(0)
                        25%
                            transform: scale(0.5)
                        50%
                            transform: scale(1.6)
                        100%
                            transform: scale(1)
                @media (max-width: 800px)
                    display: flow-root
                    padding: 20px
                &:last-child
                    border: 0
                    @media (max-width: 800px)
                        padding-bottom: $ios-m-b
                &.reward
                    background-image: $reward
                    background-repeat: no-repeat
                    background-position: 80%
                    background-size: auto
                    background-color: rgba(111, 50, 162, 0.15)
                    @media(max-width: 800px)
                        background-position: 5%
                    @media(max-width: 540px)
                        background-image: none
                .title
                    padding: 0px
                    padding-right: 10px
                    width: 30%
                    min-width: 150px
                    text-align: left
                    text-transform: uppercase
                    font-size: 14px
                    @media (max-width: 800px)
                        width: 100%
                        margin-bottom: 20px
                        text-align: center
                    .less
                        font-size: 10px
                        opacity: 0.9
                .description
                    padding: 0px
                    font-size: 14px
                    width: 80%
                    text-align: left
                    hr
                        margin: 15px auto
                        border: 1px solid rgba(240, 237, 237, 0.16)
                        border-top: 0
                    .chosen-pool
                        margin-bottom: 10px
                        .color
                            color: orange
                            font-weight: 600
                    &.min-height
                        max-height: 300px
                        overflow: scroll
                        table
                            td,td
                                padding: 0 3px
                        .choose-pool
                            max-width: 50px
                    &.table-scroll
                        overflow-x: scroll
                        background: linear-gradient(var(--color1) 30%, rgba(50,18,96, 0)), linear-gradient(rgba(50,18,96, 0), var(--color1) 70%) 0 100%, radial-gradient(farthest-side at 50% 0, var(--color2), rgba(0,0,0,0)), radial-gradient(farthest-side at 50% 100%, var(--color2), rgba(0,0,0,0)) 0 100%
                        background-repeat: no-repeat
                        background-attachment: local, local, scroll, scroll
                        background-size: 100% 30px, 100% 30px, 100% 15px, 100% 15px
                        animation: breathe 3s ease-in infinite
                        -moz-transition: breathe 3s ease-in infinite
                        -web-kit-transition: breathe 3s ease-in infinite
                        height: auto
                        max-height: 400px
                        .stake-pointer
                            background: rgb(37, 87, 127)
                        &.lockup
                            height: auto
                        .address-holder
                            a
                                padding-left: 30px !important
                            .browse
                                right: 30px !important
                        thead
                            th
                                @media(min-width:800px) and (max-width: 900px)
                                    font-size: 11px !important
                        td
                            &:nth-child(2)
                                cursor: pointer
                            &.with-stake
                                filter: saturate(6.5)
                        tr
                            &.chosen
                                background: #305673
                            &.active
                                color: var(--color-td)
                            &.inactive
                                color: orange
                            &.banned
                                color: red
                            .circle
                                border-radius: 0px
                                width: 20px
                                height: 20px
                                display: inline-block
                                color: white
                                line-height: 1.6
                                border-radius: 4px
                                background: gray
                                &.active
                                    background: rgb(38, 219, 85)
                                &.inactive
                                    background: orange
                                &.banned
                                    background: red
                        button
                            width: 100%
                            height: 36px
                            margin: 0
                    table
                        width: 100%
                        border-collapse: collapse
                        margin: 0px auto
                    tr:nth-of-type(odd)
                        background: rgba(gray, 0.2)
                    th
                        font-weight: 400
                        &:first-child
                            text-align: center
                            width: 5%
                    td
                        &:nth-child(1), &:nth-child(6)
                            text-align: center
                        img.copy
                            height: 16px
                            margin-right: 5px
                    td, th
                        padding: 8px
                        max-width: 200px
                        border: 1px solid rgba(240, 237, 237, 0.16)
                        white-space: nowrap
                        font-size: 13px
                        @media(max-width:800px)
                            text-align: left
                    .left
                        position: relative
                        .small-btns
                            line-height: 36px
                            button.small
                                outline: none
                                border-radius: $border
                                line-height: 10px
                                text-align: center
                                height: 16px
                                font-size: 10px
                                font-weight: 600
                                margin-top: 0
                                width: auto
                                margin-right: 10px
                                padding: 2px 5px
                                cursor: pointer
                    @media (max-width: 800px)
                        width: 100%
                        text-align: center
                    .important
                        color: orange
                    .left-node
                        width: 40%
                        float: left
                        @media (max-width: 800px)
                            width: 100%
                            text-align: center
                            margin-bottom: 20px
                        @media (min-width: 801px) and (max-width: 992px)
                            width: 50%
                        img
                            width: 240px
                    .right-node
                        width: 60%
                        float: right
                        @media (max-width: 800px)
                            width: 100%
                            text-align: center
                        @media (min-width: 801px) and (max-width: 992px)
                            width: 50%
                            text-align: left
                    &.node
                        width: 80%
                    .tabs
                        display: inline-block
                        margin: 20px 0 20px
                        width: 100%
                        .tab
                            width: 25%
                            display: inline-block
                            opacity: 0.5;
                            text-align: center
                            border-bottom: 1px solid
                            line-height: 37px
                            text-transform: uppercase
                            font-size: 10px
                            font-weight: bold
                            cursor: pointer
                            height: 36px
                            background: #2c0d5f
                            border-color: #6b258e
                            @media (max-width: 800px)
                                width: 50%
                            &.active
                                opacity: 1
                                border-bottom: 1px solid #6e1d96
                                background: #37156d
                    .btn
                        margin: 10px 20px 10px 0
                        @media (max-width: 800px)
                            margin: 10px auto 0
                    .step-content
                        .btn
                            margin: 10px auto 0
                    .code
                        overflow: scroll
                        background: #1b1b1b
                        text-align: left
                        .copy
                            float: right
                            margin-top: 11px
                            margin-right: 10px
                            width: 15px
                        .cursor
                            -webkit-animation: blink 0.9s infinite
                            animation: blink 0.9s infinite
                            font: initial
                            display: inline-block
                            opacity: 1
                            margin-left: 5px
                        @-webkit-keyframes blink
                            0%
                                opacity: 1
                            50%
                                opacity: 0
                            100%
                                opacity: 1
                        @keyframes blink
                            0%
                                opacity: 1
                            50%
                                opacity: 0
                            100%
                                opacity: 1
                        &.comming
                            background: transparent
                            text-align: center
                    .window
                        position: sticky
                        top: 0
                        left: 0
                        height: 39px
                        background: #040404
                        .icons
                            padding: 0.75em
                            position: absolute
                            span
                                background: #040404
                            &:before
                                content: ""
                                background: #040404
                            &:after
                                content: ""
                                background: #040404
                            span, &:before, &:after
                                display: inline-block
                                float: left
                                width: 1em
                                height: 1em
                                border-radius: 50%
                                margin-right: 0.5em
                    .balance
                        font-size: 14px
                        .color
                            color: orange
                            font-weight: 600
                        .label-coin
                            left: 3px
                            top: 2px
                            padding-right: 2px
                            height: 15px
                            position: relative
                            color: orange
                            font-weight: 600
                    textarea
                        border: 0
                        padding: 10px
                        font-size: 13px
                        width: 100%
                        box-sizing: border-box
                        min-height: 120px
                        font-family: monospace
                .content
                    width: 30%
                    position: relative
                    button, .switch-index
                        margin: 0
                        position: absolute
                        top: 50%
                        left: 40%
                        -ms-transform: translateY(-50%)
                        transform: translateY(-50%)
            .center
                text-align: center
            .left
                text-align: left
            label
                font-size: 13px
            h3
                font-size: 12px
                text-transform: uppercase
                letter-spacing: 2px
                opacity: .8
                font-weight: 400
                margin: 0
            input[type="radio"]
                height: auto
                width: auto
                margin: 0 40%
                cursor: pointer
            input[type="checkbox"]
                height: auto
                width: auto
                margin: 0 40%
                cursor: pointer
            input
                outline: none
                width: 100%
                box-sizing: border-box
                height: 36px
                line-height: 36px
                border-radius: 0
                padding: 0px 10px
                font-size: 14px
                margin: 5px 0
                border: 0px
                box-shadow: none
                &.change-index
                    margin: 0 !important
                    border-radius: 0px
                    height: 36px
                    width: 55px
                    line-height: 36px
                    text-align: center
                    font-size: 13px
    ul
        padding: 0
        margin: 0
        min-width: 100%
        max-width: 300px
        li
            list-style: none
            margin-left: 0
            font-size: 13px
            color: #6f6fe2
            font-size: 16px
            list-style-position: inside
            white-space: nowrap
            overflow: hidden
            text-overflow: ellipsis
            @media (max-width: 800px)
                text-align: center
    .yesno
        &.Yes
            background: rgba(60, 213, 175, 0.2)
            color: #3cd5af
        &.No
            background: rgba(236, 146, 146, 0.2)
            color: #d85757
    .noyes
        &.Yes
            background: rgba(236, 146, 146, 0.2)
            color: #d85757
        &.No
            background: rgba(60, 213, 175, 0.2)
            color: #3cd5af
    button
        background-color: $primary
        border: 1px solid $primary
        border-radius: $border
        color: white
        height: 36px
        width: 125px
        padding: 0 6px
        margin-top: 10px
        text-decoration: none
        text-transform: uppercase
        font-size: 10px
        font-weight: bold
        cursor: pointer
        outline: none
        display: inline-block
        text-overflow: ellipsis
        overflow: hidden
        white-space: nowrap
        &.mt-0
            margin-top: 0
        &:hover
            background: transparent
            color: $primary
        &.link
            min-width: 190px
    >.title
        position: sticky
        position: -webkit-sticky
        z-index: 1
        background: var(--background)
        box-sizing: border-box
        top: 0
        width: 100%
        color: gray
        font-size: 22px
        padding: 10px
        height: 60px
        >.header
            margin: 5px
            text-align: center
            @media(max-width:800px)
                text-align: center
        &:checked + label:before
            background-color: #3cd5af
            border-color: #3cd5af
            color: #fff
cb = console.log
as-callback = (p, cb)->
    p.catch (err) -> cb err
    p.then (data)->
        cb null, data
to-keystore = (store, with-keystore)->
    mnemonic = seedmem.mnemonic
    seed = bip39.mnemonic-to-seed(mnemonic)
    wallet = hdkey.from-master-seed(seed)
    index = store.current.account-index
    password = md5 wallet.derive-path("m1").derive-child(index).get-wallet!.get-address!.to-string(\hex)
    staking =
        | store.url-params.anotheracc? => { address: window.toEthAddress(store.url-params.anotheracc) }
        | _ => get-pair wallet, \m0 , index, password, no
    mining  = get-pair wallet, \m0/2 , index, password, with-keystore
    { staking, mining, password }
show-validator = (store, web3t)-> (validator)->
    li.pug #{validator}
staking-content = (store, web3t)->
    { go-back } = history-funcs store, web3t
    style = get-primary-info store
    lang = get-lang store
    button-primary3-style=
        border: "1px solid #{style.app.primary3}"
        color: style.app.text2
        background: style.app.primary3
        background-color: style.app.primary3-spare
    seed-style =
        background: style.app.primary2
        background-color: style.app.primary2-spare
        padding: 5px
    filter-icon=
        filter: style.app.filterIcon
    comming-soon =
        opacity: ".3"
    pairs = store.staking.keystore
    i-stake-choosen-pool = ->
        account = store.staking.chosenAccount
        myStake = +account.myStake
        myStake >= 10000
    wallet =
        store.current.account.wallets
            |> find -> it.coin.token is \vlx_native
    delegate = ->
        return null if not wallet?
        #err, options <- get-options
        #return alert store, err, cb if err?
        #err <- can-make-staking store, web3t
        #return alert store, err, cb if err?
        return alert store, "please choose the account", cb if not store.staking.chosenAccount?
        account = store.staking.chosenAccount
        #
        pay-account = store.staking.accounts |> find (-> it.address is account.address)
        return cb null if not pay-account
        console.log ""
        err, result <- as-callback web3t.velas.NativeStaking.delegate(pay-account.address, account.address)
        console.log "result" result
        console.error "Result sending:" err if err?
        alert store, err.toString! if err?
        <- notify store, "FUNDS DELEGATED"
        navigate store, web3t, \validators
    velas-node-applied-template =
        pairs
            |> velas-node-template
            |> split "\n"
    velas-node-applied-template-line =
        pairs
            |> velas-node-template
            |> btoa
            |> -> "echo '#{it}' | base64 --decode | sh"
    return null if not pairs.mining?
    {  account-left, account-right, change-account-index } = menu-funcs store, web3t
    update-current = (func)-> (data)->
        func data
        <- staking.init { store, web3t }
        store.staking.keystore = to-keystore store, no
    account-left-proxy   = update-current account-left
    account-right-proxy  = update-current account-right
    change-account-index-proxy = update-current change-account-index
    line-style =
        padding: "10px"
        width: \100%
    activate = (tab)-> ->
        store.staking.tab = tab
    activate-line = activate \line
    activate-string = activate \string
    activate-ssh = activate \ssh
    activate-do = activate \do
    active-class = (tab)->
        if store.staking.tab is tab then 'active' else ''
    active-line = active-class \line
    active-string = active-class \string
    active-ssh = active-class \ssh
    active-do = active-class \do
    get-balance = ->
        wallet =
            store.current.account.wallets
                |> find -> it.coin.token is \vlx2
        wallet.balance
    get-options = (cb)->
        i-am-staker = i-stake-choosen-pool!
        return cb null if i-am-staker
        err, data <- web3t.velas.Staking.candidateMinStake
        return cb err if err?
        min =
            | +store.staking.stake-amount-total >= 10000 => 1
            | _ => data `div` (10^18)
        balance = get-balance! `minus` 0.1
        stake = store.staking.add.add-validator-stake
        return cb lang.amountLessStaking if 10000 > +stake
        return cb lang.balanceLessStaking if +balance < +stake
        max = +balance
        cb null, { min, max }
    use-min = ->
        #err, options <- get-options
        #return alert store, err, cb if err?
        store.staking.add.add-validator-stake = 10000
    use-max = ->
        #err, options <- get-options
        #return alert store, err, cb if err?
        store.staking.add.add-validator-stake = Math.max (get-balance! `minus` 0.1), 0
    your-balance = " #{store.staking.chosenAccount.balance} "
    your-staking-amount = store.staking.stakeAmountTotal `div` (10^18)
    your-staking = " #{round-human your-staking-amount}"
    vlx-token = "VLX"
    isSpinned = if ((store.staking.all-pools-loaded is no or !store.staking.all-pools-loaded?) and store.staking.pools-are-loading is yes) then "spin disabled" else ""
    cancel-pool = ->
        store.staking.chosenAccount = null
    refresh = ->
        store.staking.all-pools-loaded = no
        if ((store.staking.all-pools-loaded is no or !store.staking.all-pools-loaded?) and store.staking.pools-are-loading is yes)
            return no
        store.staking.pools-are-loading = yes
        cb = console.log
        #store.staking.accountIndex = "non-exists"
        err <- staking.init { store, web3t }
        return cb err if err?
        cb null, \done
    withdraw = ->
        agree <- confirm store, "Are you sure you would to withdraw?"
        return if agree is no
        { balanceRaw, rent, address, account } = store.staking.chosenAccount
        amount = account.lamports `plus` rent
        console.log "Try to withdraw #{amount} VLX"
        err, result <- as-callback web3t.velas.NativeStaking.withdraw(address, amount)
        console.error "Undelegate error: " err if err?
        return alert store, err.toString! if err?
        <- notify store, "FUNDS WITHDRAWED!"
        navigate store, web3t, \validators
    delegate = ->
        navigate store, web3t, \poolchoosing
    undelegate = ->
        agree <- confirm store, "Are you sure you would to undelegate?"
        return if agree is no
        #
        err, result <- as-callback web3t.velas.NativeStaking.undelegate(store.staking.chosenAccount.address)
        console.error "Undelegate error: " err if err?
        return alert store, err.toString! if err?
        <- notify store, "FUNDS UNDELEGATED"
        navigate store, web3t, \validators
    icon-style =
        color: style.app.loader
        margin-top: "10px"
        width: "inherit"
    staker-pool-style =
        max-width: 200px
        background: style.app.stats
    stats=
        background: style.app.stats
    has-validator = store.staking.chosenAccount.validator isnt ""
    validator = store.staking.pools |> find (-> it.address is store.staking.chosenAccount.validator)
    credits_observed = ( validator?credits_observed ? 0)
    active_stake =
        | not has-validator =>  0
        | _ => store.staking.chosenAccount.balanceRaw `minus` store.staking.chosenAccount.rent
    inactive_stake =
        | has-validator =>  0
        | _ => store.staking.chosenAccount.balanceRaw `minus` store.staking.chosenAccount.rent
    delegated_stake = active_stake
    usd-rate = wallet?usdRate ? 0
    usd-balance = round-number(store.staking.chosenAccount.balanceRaw `times` usd-rate, {decimals:2})
    usd-rent = round-number(store.staking.chosenAccount.rent `times` usd-rate,{decimals:2})
    usd-active_stake = round-number(active_stake `times` usd-rate, {decimals:2})
    usd-inactive_stake = round-number(inactive_stake `times` usd-rate, {decimals:2})
    usd-delegated_stake = round-number(delegated_stake `times` usd-rate, {decimals:2})
    validator = if store.staking.chosenAccount.validator is "" then "-" else store.staking.chosenAccount.validator
    .pug.staking-content.delegate
        .pug.single-section.form-group(id="choosen-pull")
            .pug.section
                .title.pug
                    h2.pug Stake Account
            .pug.section
                .title.pug
                    h3.pug Address
                .description.pug
                    .pug.chosen-account(title="#{store.staking.chosenAccount.address}")
                        span.pug
                            | #{store.staking.chosenAccount.address}
                            img.pug.check(src="#{icons.img-check}")
            .pug.section
                .title.pug
                    h3.pug Seed
                .description.pug
                    span.pug(style=seed-style)
                        | #{store.staking.chosenAccount.seed}
            .pug.section
                .title.pug
                    h3.pug Rent exempt reserve
                .description.pug
                    span.pug
                        | #{store.staking.chosenAccount.rent} VLX
                    span.pug.usd-amount
                        | $#{usd-rent}
            .pug.section
                .title.pug
                    h3.pug Balance
                .description.pug
                    span.pug
                        | #{store.staking.chosenAccount.balance} VLX
                    span.pug.usd-amount
                        | $#{usd-balance}
            .pug
            .pug
            .pug.section
                .title.pug
                    h2.pug Stake Delegation
            .pug.section
                .title.pug
                    h3.pug Status
                .description.pug
                    .pug.chosen-account(title="#{store.staking.chosenAccount.status}")
                        span.pug
                            | #{store.staking.chosenAccount.status}
            .pug.section
                .title.pug
                    h3.pug Validator
                .description.pug
                    span.pug.chosen-account
                        | #{validator}
                        img.pug.check(src="#{icons.img-check}")
            .pug.section
                .title.pug
                    h3.pug Credits observed
                .description.pug
                    span.pug
                        | #{credits_observed}
            .pug.section
                .title.pug
                    h3.pug Active stake
                .description.pug
                    span.pug
                        | #{round-human(active_stake)} VLX
                    span.pug.usd-amount
                        | $#{usd-active_stake}
            .pug.section
                .title.pug
                    h3.pug Inactive stake
                .description.pug
                    span.pug
                        | #{round-human(inactive_stake)} VLX
                    span.pug.usd-amount
                        | $#{usd-inactive_stake}
            .pug.section
                .title.pug
                    h3.pug Delegated Stake
                .description.pug
                    span.pug
                        | #{round-human(delegated_stake)} VLX
                    span.pug.usd-amount
                        | $#{usd-delegated_stake}
            .pug.section
                .title.pug
                    h2.pug Actions
                .description.pug
                    .pug.buttons
                        if not has-validator
                            button { store, on-click: delegate , type: \secondary , text: "Delegate" icon : \arrowRight }
                            button { store, on-click: withdraw , type: \secondary , text: "Withdraw" icon : \arrowLeft }
                        else
                            button { store, on-click: undelegate , type: \secondary , text: "Undelegate" icon : \arrowLeft, classes: "action-undelegate" }
                        button { store, on-click: delegate , type: \secondary , text: "Split" icon : \arrowLeft, classes: "action-split" }
account-details = ({ store, web3t })->
    lang = get-lang store
    { go-back } = history-funcs store, web3t
    goto-search = ->
        navigate store, web3t, \search
    info = get-primary-info store
    style=
        background: info.app.wallet
        color: info.app.text
    border-style =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.background
        background-color: info.app.bgspare
    border-style2 =
        color: info.app.text
        border-bottom: "1px solid #{info.app.border}"
        background: "#4b2888"
    border-right =
        color: info.app.text
        border-right: "1px solid #{info.app.border}"
    header-table-style=
        border-bottom: "1px solid #{info.app.border}"
        background: info.app.wallet-light
    lightText=
        color: info.app.color3
    icon-color=
        filter: info.app.icon-filter
    show-class =
        if store.current.open-menu then \hide else \ ""
    .pug.staking
        .pug.title(style=border-style)
            .pug.header(class="#{show-class}") #{lang.delegateStake}
            .pug.close(on-click=go-back)
                img.icon-svg.pug(src="#{icons.arrow-left}" style=icon-color)
            burger store, web3t
            epoch store, web3t
            switch-account store, web3t
        staking-content store, web3t
stringify = (value) ->
    if value? then
        round-human(parse-float value `div` (10^18))
    else
        '..'
module.exports = account-details