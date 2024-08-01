import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class extends Route {
  @service db;

  async model() {
    const last = await this.db.getLastUpdate();
    return last;
  }
}
