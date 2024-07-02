import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class SearchResultRoute extends Route {
  @service('db') db;

  async model() {
    const searchResult = await this.db.search();
    return searchResult;
  }
}
