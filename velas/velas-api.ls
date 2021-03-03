require! {
    \./velas-web3.ls
    \./addresses.ls
}
abis =
    Staking      : require("./contracts/StakingAuRa.json").abi
    ValidatorSet : require("./contracts/ValidatorSetAuRa.json").abi
    BlockReward  : require("./contracts/BlockRewardAuRa.json").abi
    Development  : require("./contracts/VelasDevelopment.json").abi
    Resolver     : require("./contracts/LockupResolver.json").abi
    Timelock     : require("./contracts/LockupTimelock.json").abi
    HomeBridgeNativeToErc  : require("./contracts/HomeBridgeNativeToErc.json").abi 
    ForeignBridgeNativeToErc : require("./contracts/ForeignBridgeNativeToErc.json").abi 
    ERC20BridgeToken: require("./contracts/ERC20BridgeToken.json").abi    
module.exports = (store)->
    web3 = velas-web3 store
    Development-contract-address =
        if store.current.network is \testnet
            addresses.DevelopmentTest
        else
            addresses.Development
    resolver-contract-address = 
        if store.current.network is \testnet
            addresses.ResolverAuRaTestnet
        else
            addresses.ResolverAuRaMainnet
    api =
        Staking      : web3.eth.contract(abis.Staking).at(addresses.Staking)
        StakingLockup: web3.eth.contract(abis.Staking)
        ValidatorSet : web3.eth.contract(abis.ValidatorSet).at(addresses.ValidatorSet)
        BlockReward  : web3.eth.contract(abis.BlockReward).at(addresses.BlockReward)
        Development  : web3.eth.contract(abis.Development).at(Development-contract-address)
        Resolver     : web3.eth.contract(abis.Resolver).at(resolver-contract-address)
        Timelock     : web3.eth.contract(abis.Timelock) 
        web3         : web3.eth
        HomeBridgeNativeToErc : web3.eth.contract(abis.HomeBridgeNativeToErc).at(addresses.HomeBridge)
        ForeignBridgeNativeToErc : web3.eth.contract(abis.ForeignBridgeNativeToErc).at(addresses.ForeignBridge)
        ERC20BridgeToken : web3.eth.contract(abis.ERC20BridgeToken).at(addresses.ERC20BridgeToken) 
    api