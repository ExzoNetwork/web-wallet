require! {
    \web3 : Web3
}
#security updates (TODO check more)
#
networks =
    mainnet: \https://34.172.139.51:8545
    testnet: \https://35.239.10.9:8545
module.exports = (store)->
    network = networks[store.current.network]
    web3 = new Web3(new Web3.providers.HttpProvider(network))
    delete web3.eth.send-transaction
    delete web3.eth.send-signed-transaction
    delete web3.eth.send-raw-transaction
    delete web3.personal
    delete web3.eth.accounts
    delete web3.eth.getAccounts
    delete web3.eth.sign
    web3.eth.provider-url = network
    web3