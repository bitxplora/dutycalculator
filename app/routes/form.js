import Route from '@ember/routing/route';
import { service } from '@ember/service';
import { hash } from 'rsvp';

export default class FormRoute extends Route {
  @service db;

  model() {
    return hash({
      itemSelected: this.db.getSelected(),
      currencies: [
        'AED',
        'AUD',
        'BRL',
        'CAD',
        'CFA',
        'CHF',
        'CNY',
        'CVE',
        'CZK',
        'DKK',
        'EGP',
        'ETB',
        'EUR',
        'FCF',
        'GBP',
        'GHS',
        'GMD',
        'GNF',
        'HKD',
        'HUF',
        'IDR',
        'ILS',
        'INR',
        'JPY',
        'KES',
        'KRW',
        'LRD',
        'MAD',
        'MAK',
        'MUR',
        'MXN',
        'MYR',
        'NGN',
        'NOK',
        'PHP',
        'PKR',
        'PLN',
        'RUB',
        'SAR',
        'SDG',
        'SEK',
        'SGD',
        'SLL',
        'THB',
        'TND',
        'TRY',
        'TWD',
        'USD',
        'WAU',
        'XAF',
        'XDR',
        'XOF',
        'ZAR',
        'ZMK',
      ],
    });
  }
}
