import { test } from '../../common-test-exports';
import { Currency } from '../../screens';
import { log } from '../../tools/logger';

test.describe('Bridge test 2:', () => {
  const today = new Date().toLocaleDateString('nu').replace(/\//g, '');

  test.beforeEach(async ({ auth }) => {
    await auth.goto({environment: 'prod'});
    await auth.loginByRestoringSeed(today);
  });

  test('check balances are not zero', async ({ wallets }) => {
    const tokens : Currency[] = [
      'token-bsc_xzo', 'token-xzo_huobi', 'token-bnb', 'token-busd', 
      'token-eth', 'token-huobi', 'token-usdc', 'token-usdt_erc20', 
      'token-xzo_busd', 'token-xzo_erc20', 'token-xzo_eth', 'token-xzo_evm',
      'token-xzo_usdc', 'token-xzo_usdt'
    ]

    for(let token of tokens){
      await wallets.addToken(token);
    };

    let balances = await wallets.getWalletsBalances();

    for (let tokenName in balances) {
      const token = tokenName as Currency;
      if (token === 'token-xzo_evm' && Number(balances[token]) < 0.000007){
        throw new Error (`Balance of ${token} is ${balances[token]}, 0.000007 expected`)
      }
      if (token !== 'token-xzo_evm' && tokens.includes(token as Currency) && Number(balances[token]) === 0){
        throw new Error (`Balance of ${token} is zero`)
      }
    }
    log.debug(balances);
  });
});
