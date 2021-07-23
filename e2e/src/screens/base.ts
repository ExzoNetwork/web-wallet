import { log } from '../tools/logger';
import { Browser, BrowserContext, Page } from '../types';

type MenuItem = 'wallets' | 'staking' | 'search' | 'settings' | 'support';

export abstract class BaseScreen {
  context: BrowserContext;

  browser: Browser;

  constructor(public page: Page) {
    this.context = this.page.context();
    const browser = this.context.browser();
    if (!browser) throw new Error('Browser was closed');
    this.browser = browser;
  }

  async confirmPrompt(): Promise<void> {
    await this.page.click('#prompt-confirm');
  }

  async isLoggedIn(): Promise<boolean> {
    try {
      await this.page.waitForSelector('.balance', { timeout: 500 });
      log.info('User is logged in');
      return true;
    } catch (e) {
      log.info('User is not logged in');
      return false;
    }
  }

  async openMenu(item: MenuItem): Promise<void> {
    // add new type property to correspond html classname (staking menu item has class "delegate")
    let menuItemName: MenuItem | 'delegate' = item;
    if (item === 'staking') menuItemName = 'delegate';
    await this.page.click(`#menu-${menuItemName}`);

    // wait for wallets data loaded
    if (menuItemName === 'wallets') {
      await this.page.waitForSelector('.wallet-item .top-left [class=" img"]', { state: 'visible' });
    }
  }
}
