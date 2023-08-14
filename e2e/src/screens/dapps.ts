import { Page } from '../common-test-exports';
import { BaseScreen } from './base';

export class DAppsScreen extends BaseScreen {
  constructor(public page: Page) {
    super(page);
  }

  oldStaking = this.page.locator('" Exzo Staking 1.0"');
}
