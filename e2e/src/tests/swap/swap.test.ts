import { velasNative } from '@velas/velas-chain-test-wrapper';
import {
  bscchain, evmchain, hecochain, ropsten,
} from '../../api/explorers-api';
import { data, test } from '../../common-test-exports';
import { log } from '../../tools/logger';

test.describe('Swap', () => {
  const transactionsInProgress: Promise<any>[] = [];
  const isSmokeRun = process.env.SMOKE === 'true';
  log.warn(`${isSmokeRun ? 'Only tests marked @smoke will be run' : 'All smoke tests will be run'}`);

  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.swap.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test.afterAll(async () => {
    await Promise.all(transactionsInProgress);
  });

  test.describe('Inside Velas network: ', () => {
    test('XZO Native (Velas) > XZO EVM (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_native', 'token-xzo_evm', '0.0001');
      await wallets.txListAfterSendOrSwap.linkToTxExecuted.waitFor({ timeout: 30000 });
      const txSignature = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(velasNative.waitForConfirmedTransaction(txSignature));
    });

    test('Error: Not enough funds @smoke', async ({ page, wallets }) => {
      await wallets.swapTokens('token-xzo_native', 'token-xzo_evm', '9999999999', { confirm: false });
      await page.locator('" Not Enough Funds"').waitFor();
    });

    test('XZO Native (Velas) > XZO Legacy (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_native', 'token-xzo2', '0.0001');
      await wallets.txListAfterSendOrSwap.linkToTxExecuted.waitFor({ timeout: 30000 });
      const txSignatureLink = await wallets.txListAfterSendOrSwap.linkToTxExecuted.getAttribute('href');
      if (!txSignatureLink) throw new Error('No txSignatureLink');
      const txSignature = txSignatureLink.replace('https://native.velas.com/tx/', '');
      transactionsInProgress.push(velasNative.waitForConfirmedTransaction(txSignature));
    });

    test('XZO EVM (Velas) > XZO Native (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_evm', 'token-xzo_native', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('XZO EVM (Velas) > XZO Legacy (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_evm', 'token-xzo2', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('XZO Legacy (Velas) > XZO Native (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo2', 'token-xzo_native', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('XZO Legacy (Velas) > XZO EVM (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo2', 'token-xzo_evm', '0.0001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  test.describe('From Velas network', async () => {
    test('XZO EVM (Velas) > XZO ERC-20 (Ethereum) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_evm', 'token-xzo_erc20', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // bsc is down too often; test may be unstable
    test('XZO EVM (Velas) > XZO BEP-20 (BSC) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_evm', 'token-bsc_xzo', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('XZO EVM (Velas) > XZO HRC-20 (Heco) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_evm', 'token-xzo_huobi', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // TODO: no tokens! need replenishment
    test('USDC (Velas) > USDC (Ethereum) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_usdc', 'token-usdc', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('ETH VRC-20 (Velas) > ETH (Ethereum) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_eth', 'token-eth', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('USDT (Velas) > USDT (Ethereum)', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_usdt', 'token-usdt_erc20', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // to run this test, min amount per tx should be larger that bridge fee, but now its smaller
    // TODO: run on mainnet
    test.skip('USDT (Velas) > USDT (Ethereum): min amount per tx error', async ({ auth, page, wallets }) => {
      await auth.goto({ network: 'mainnet' });
      await auth.pinForLoggedOutAcc.typeAndConfirm('111222');
      await wallets.waitForWalletsDataLoaded();

      await wallets.swapTokens('token-bsc_xzo', 'token-xzo_evm', '0.0000001', { confirm: false });
      await (page.locator('button :text("swap")')).click();
      await page.locator('" Min amount per transaction is 1 XZO"').waitFor();
    });

    // to run this test bridge fee should be larger than min amount
    // TODO: maybe could be run on mainnnet
    test.skip('USDT (Velas) > USDT (Ethereum): amount is less than bridge fee @smoke', async ({ page, wallets }) => {
      await wallets.swapTokens('token-xzo_usdt', 'token-usdt_erc20', '0.000001', { confirm: false });
      await page.locator('" Amount 0.000001 is less than bridge fee (0.001)"').waitFor();
    });

    test('BUSD (Velas) > BUSD (BSC) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_busd', 'token-busd', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  // TODO: migrate from Ropsten
  test.describe.skip('From Ethereum network', async () => {
    // ETH ropsten testnet has a huge gas price (111,363 Gwei)
    test('ETH (Ethereum) > ETH VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-eth', 'token-xzo_eth', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('USDC (Ethereum) > USDC VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-usdc', 'token-xzo_usdc', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    // BUG: 0 fee error
    test('XZO ERC-20 (Ethereum) > XZO EVM (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_erc20', 'token-xzo_evm', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });

    test('USDT (Ethereum) > USDT VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-usdt_erc20', 'token-xzo_usdt', '0.000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  test.describe('From BSC network', async () => {
    test('XZO BEP-20 (BSC) > XZO EVM (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-bsc_xzo', 'token-xzo_evm', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }))
    });

    test('BUSD (BSC) > BUSD VRC-20 (Velas)', async ({ wallets }) => {
      await wallets.swapTokens('token-busd', 'token-xzo_busd', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });

  test.describe('From HECO network', async () => {
    test('XZO HRC-20 (Heco) > XZO EVM (Velas) @smoke', async ({ wallets }) => {
      await wallets.swapTokens('token-xzo_huobi', 'token-xzo_evm', '0.00000001');
      const txHash = await wallets.getTxHashFromTxlink();
      transactionsInProgress.push(hecochain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: !isSmokeRun }));
    });
  });
});
