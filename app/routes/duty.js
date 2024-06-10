import Route from '@ember/routing/route';
import { hash } from 'rsvp';

export default class Duty extends Route {
  model() {
    return hash({
      customData: {
        cerCode: 750720000,
        id: 10,
        lvy: 0,
        vat: 7.5,
      },
      userData: {
        fob: 69_808,
        freight: 1_000,
        insurance: 500,
      },
    });
  }
}
