import {
  bscchain, evmchain, hecochain, ropsten,
} from '../../api/explorers-api';
import { data, test } from '../../common-test-exports';

test.describe('Custom swap from Exzo network', () => {
  const transactionsInProgress: Promise<any>[] = [];
  const minSwapAmount = '0.00000001';
  const minSwapAmountUsdtUsdc = '0.000001';

  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.customSwapFromVelas.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test.afterAll(async () => {
    await Promise.all(transactionsInProgress);
  });

  test('XZO EVM (Exzo) > XZO ERC-20 (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_evm', 'token-xzo_erc20', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('XZO EVM (Exzo) > XZO BEP-20 (BSC)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_evm', 'token-bsc_xzo', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('XZO EVM (Exzo) > XZO HRC-20 (Heco)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_evm', 'token-xzo_huobi', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('USDC (Exzo) > USDC (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_usdc', 'token-usdc', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('ETH VRC-20 (Exzo) > ETH (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_eth', 'token-eth', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('USDT (Exzo) > USDT (Ethereum)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_usdt', 'token-usdt_erc20', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('BUSD (Exzo) > BUSD (BSC)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_busd', 'token-busd', minSwapAmount, {customAddress: data.wallets.customSwapToVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(evmchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));    
  });
});

test.describe('Custom swap to Exzo network', () => {
  const transactionsInProgress: Promise<any>[] = [];
  const minSwapAmount = '0.00000001';
  const minSwapAmountUsdtUsdc = '0.000001';

  test.beforeEach(async ({ auth, wallets }) => {
    await auth.goto();
    await auth.loginByRestoringSeed(data.wallets.customSwapToVelas.seed);
    await wallets.waitForWalletsDataLoaded();
  });

  test.afterAll(async () => {
    await Promise.all(transactionsInProgress);
  });

  // TODO: migrate from Ropsten
  test.skip('ETH (Ethereum) > ETH VRC-20 (Exzo)', async ({ wallets }) => {
    await wallets.swapTokens('token-eth', 'token-xzo_eth', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  // TODO: migrate from Ropsten
  test.skip('USDC (Ethereum) > USDC VRC-20 (Exzo)', async ({ wallets }) => {
    await wallets.swapTokens('token-usdc', 'token-xzo_usdc', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  // TODO: migrate from Ropsten
  test.skip('XZO ERC-20 (Ethereum) > XZO EVM (Exzo)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_erc20', 'token-xzo_evm', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  // TODO: migrate from Ropsten
  test.skip('USDT (Ethereum) > USDT VRC-20 (Exzo)', async ({ wallets }) => {
    await wallets.swapTokens('token-usdt_erc20', 'token-xzo_usdt', minSwapAmountUsdtUsdc, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(ropsten.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('XZO BEP-20 (BSC) > XZO EVM (Exzo)', async ({ wallets }) => {
    await wallets.swapTokens('token-bsc_xzo', 'token-xzo_evm', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }))
  });

  test('BUSD (BSC) > BUSD VRC-20 (Exzo)', async ({ wallets }) => {
    await wallets.swapTokens('token-busd', 'token-xzo_busd', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(bscchain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));
  });

  test('XZO HRC-20 (Heco) > XZO EVM (Exzo)', async ({ wallets }) => {
    await wallets.swapTokens('token-xzo_huobi', 'token-xzo_evm', minSwapAmount, {customAddress: data.wallets.customSwapFromVelas.evmAddress});
    const txHash = await wallets.getTxHashFromTxlink();
    transactionsInProgress.push(hecochain.waitForTx({ txHash, testName: test.info().title, waitForConfirmation: true }));  
  });
});
