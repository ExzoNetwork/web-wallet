require! {
    \../../web3t/providers/solana/index.cjs.js : solanaWeb3
}
#security updates (TODO check more)
#
networks =
    mainnet: \https://34.172.139.51:8545
    testnet: \https://35.239.10.9:8545
    devnet:  \https://api.devnet.velas.com
module.exports = (store)->
    network = networks[store.current.network]
    new solanaWeb3.Connection(network)
    #balance <- web3.getBalance("BfWa6h1X1ePv8MqfkTFapPx3E4dFc8x4bRSah9SQi2E9").then
    #console.log "web3 balance"  balance
    solanaWeb3._rpcEndpoint = network
    solanaWeb3