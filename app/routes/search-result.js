import Route from '@ember/routing/route';
import { service } from '@ember/service';

export default class SearchResultRoute extends Route {
  @service('db') db;

  model() {
    const searchResult = this.db.search();
    return searchResult;
  }
}
