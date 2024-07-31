import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class FormRoute extends Route {
  @service db;

  model() {
    return hash({
      itemSelected: this.db.getSelected(),
      currencies: this.db.getCurrencyCodes(),
    });
  }
}
