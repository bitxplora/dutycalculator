import Component from '@glimmer/component';
import { service } from '@ember/service';

export default class Estimate extends Component {
  @service db;

  currencies;
  currenciesRatesObj;

  constructor() {
    super(...arguments);
    this.currencies = this.db.getCurrenciesAndRates();
    this.currenciesRatesObj = this.db.getCurrenciesRatesObj();
  }

  get numberOfCurrencies() {
    if (this.currencies.length > 1) {
      return true;
    } else {
      return false;
    }
  }

  get currenciesAndRates() {
    return this.currencies;
  }

  get currencyList() {
    return Object.keys(this.currenciesRatesObj).join(', ');
  }

  <template>
    <div class='dutyNoteText'>
      <p>Note:</p>
      <p>
         All the numberical figures on this page are in NGN. The exchange {{if this.numberOfCurrencies "rates" "rate"}} used to convert {{this.currencyList}}
         to NGN {{if this.numberOfCurrencies "are" "is"}} obtained from NCS website.
         The {{if this.numberOfCurrencies "rates" "rate"}} {{if this.numberOfCurrencies "are" "is"}} as follows:
      </p>
      <ul>
      {{#each this.currencies as |currency|}}
        <li> {{currency.code}}1 to NGN{{currency.rate}}</li>
      {{/each}}
      </ul>
    </div>
    <style>
      .dutyNoteText {
        width: 90%;
        margin-top: 1.5rem;
        padding: 0.8rem;
        font-size: 0.7rem;
        font-family: 'Roboto Flex';
        background-color: #cfecf7;
        border-radius: 8px;
        letter-spacing: 0.08rem;
      }
      .dutyNoteText p:first-of-type {
        font-size: 0.8rem;
        font-weight: 700;
        margin-bottom: 0;
      }
      .dutyNoteText p:last-of-type {
        margin: 0.5rem 0 0.5rem 0;
      }
    </style>
  </template>
}
