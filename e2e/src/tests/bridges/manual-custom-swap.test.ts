import { data, test } from '../../common-test-exports';
import { Currency } from '../../screens';
import { log } from '../../tools/logger';

test.describe('Swap', () => {
  const txHashes: string[] = [];
  const customAddress = '';
  let amount = '0.0001';
  const swapPairs: Currency[][] = [
    ['token-xzo_evm', 'token-xzo_erc20'],
    ['token-xzo_evm', 'token-bsc_xzo'],
    ['token-xzo_evm', 'token-xzo_huobi'],
    ['token-xzo_usdc', 'token-usdc'],
    ['token-xzo_usdt', 'token-usdt_erc20'],
    ['token-xzo_eth', 'token-eth'],
    ['token-xzo_busd', 'token-busd'],
    ['token-usdc', 'token-xzo_usdc'],
    ['token-eth', 'token-xzo_eth'],
    ['token-xzo_erc20', 'token-xzo_evm'],
    ['token-usdt_erc20', 'token-xzo_usdt'],
    ['token-bsc_xzo', 'token-xzo_evm'],
    ['token-busd', 'token-xzo_busd'],
    ['token-xzo_huobi', 'token-xzo_evm']
  ]

  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto({environment: 'prod'});
    await auth.loginByRestoringSeed(data.wallets.manualSwap.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test.afterAll(async () => {
    log.info(`List of transactions:\n${txHashes.join('\n')}`);
  });

  for (let swapPair of swapPairs) {
    test(`${swapPair.join(' > ')}`, async ({ wallets }) => {
      let [fromToken, toToken] = swapPair;
      if (fromToken === 'token-bsc_xzo') amount = '0.0002';
      if (fromToken === 'token-xzo_huobi') amount = '0.0004';
      await wallets.swapTokens(fromToken, toToken, amount, { customAddress: customAddress });
      const txHash = await wallets.getTxHashFromTxlink();
      txHashes.push(txHash);
      amount = '0.0001';
    });
  }
});
