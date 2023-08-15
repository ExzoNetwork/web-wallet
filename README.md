# Exzo Multi-Currency Wallet

### Install and run wallet locally
**Requirements:**
node version 14.16+
npm version 7+

Run `npm run setup`

OR follow next steps

1. Install node v14.16.1 (or v13.14.0 for Ubuntu 20.04+)
```
sudo apt-get update
sudo apt-get install curl make g++
curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
source ~/.bashrc   
nvm install v14.16
```
2. Install lsxc: `npm i lsxc -g`
3. `git clone https://github.com/ExzoNetwork/web-wallet`
4. `git clone https://github.com/ExzoNetwork/web3t`
5. `cd web3t && npm i`
6. Delete git cache and copy web3t to web-wallet:
   `cd .. && rm -rf web-wallet/.compiled-ssr/web3t/.git/objects/ && mkdir -p web-wallet/.compiled-ssr/ && cp -pr web3t/ web-wallet/.compiled-ssr/web3t/ && cd web-wallet`
7. `npm i`
8. Build and run wallet: `npm run wallet-start`
9. Open `127.0.0.1:8080/main-index.html`

You can also specify network by adding it as parameter: `?network=testnet`.
Do not open `localhost`, use `127.0.0.1`. Otherwise some wallet functions may work incorrectly.

## Run e2e tests
Please refer to e2e/README.md

### Install Web Wallet on your server (steps could be DEPRECATED

1. mkdir wallet-area
2. cd wallet-area
3. git clone https://github.com/ExzoNetwork/web-wallet wallet
4. git clone https://github.com/ExzoNetwork/web3t
5. cd web3t
6. npm i 
7. cd ../wallet
8. npm i 
9. npm i lsxc -g
10. npm run wallet-start
11. open http://127.0.0.1:8080

Tested with `node --version` v11.10.1


### Features

* All coins managed by single mnemonic pharse
* Ability to install/uninstall other coins from github repository
* Web3 api support for multi-currency

### Supported Browsers:

* Chrome
* Mozilla 
* Opera
* Safari

### Supported Sreens: 

* Mobile - Compact Design
* Desktop - Extended Design with Transaction History 

### Supported Coins

* XZO
* BTC (+ All OMNI)
* ETH (+ All ERC20)
