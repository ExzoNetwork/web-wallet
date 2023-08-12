require! {
    \../web3t/providers/superagent.js : { get, post }
    \atob
    \./providers.ls
    \../web3t/plugins/btc-coin.js : btc
    \../web3t/plugins/eth-coin.js : eth
    \../web3t/plugins/eth-legacy-coin.js : eth_legacy
    \../web3t/plugins/symblox.js : syx
    \../web3t/plugins/symblox-v2.js : syx2
    \../web3t/plugins/ltc-coin.js : ltc
    \../web3t/plugins/usdt-coin.js : usdt
    \../web3t/plugins/usdt_erc20.json : usdt_erc20
    \../web3t/plugins/xzo_erc20-coin.js : xzo_erc20
    \../web3t/plugins/xzo-coin.js : xzo_evm
    \../web3t/plugins/bnb-coin.js : bnb 
    \../web3t/plugins/xzo_busd-coin.js : xzo_busd
    \../web3t/plugins/busd-coin.js : busd
    \../web3t/plugins/huobi-coin.js : huobi 
    \../web3t/plugins/xzo-huobi-coin.js : xzo_huobi
    \../web3t/plugins/xzo-usdt-coin.js : xzo_usdt
    \../web3t/plugins/xzo-eth-coin.js : xzo_eth
    \../web3t/plugins/usdc-coin.js : usdc
    \../web3t/plugins/xzo_usdc-coin.js : xzo_usdc
    \../web3t/plugins/usdt_erc20_legacy-coin.json : usdt_erc20_legacy
    \../web3t/plugins/bsc-xzo-coin.js : bsc_xzo
    \../web3t/plugins/xzo-evm-legacy-coin.js : xzo_evm_legacy
    \../web3t/plugins/xzo_usdv-coin.js : xzo_usdv
}
module.exports = (cb) ->
    def = [ eth, eth_legacy, xzo_usdv, usdt, syx, syx2, usdt_erc20, ltc, xzo_erc20, xzo_evm, bnb, xzo_busd, busd, huobi, xzo_huobi, xzo_usdt, xzo_eth, usdt_erc20_legacy, usdc, xzo_usdc, bsc_xzo, xzo_evm_legacy  ]
    cb null, def