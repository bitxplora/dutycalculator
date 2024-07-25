import Component from '@glimmer/component';
import { service } from '@ember/service';
import numFormatter from '../../helpers/numFormatter';

export default class Estimate extends Component {
  @service db;

  #suppliedData;
  #cumstomData;
  currencies;
  currenciesRatesObj;

  constructor() {
    super(...arguments);
    this.#suppliedData = this.db.getFormData();
    this.#cumstomData = this.db.getSelected();
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

  get fob() {
    const fobValue = this.db.getFob();
    return fobValue;
  }

  /* Retrieved and returned Freight value from DB service */
  get freight() {
    const freightValue = this.db.getFreight();
    return freightValue;
  }

  /* Retrieved and returned Insurance value from DB service */
  get insurance() {
    const insuranceValue = this.db.getInsurance();
    return insuranceValue;
  }

  get vatRate() {
    const vat = Number(this.#cumstomData.vat);
    return vat;
  }

  get idRate() {
    const id = Number(this.#cumstomData.id);
    return id;
  }

  get lvyRate() {
    const lvy = Number(this.#cumstomData.lvy);
    return lvy;
  }

  get cif() {
    const cif = this.fob + this.freight + this.insurance;
    return cif;
  }

  get ciss() {
    const ciss = (1 / 100) * this.fob;
    return ciss;
  }

  get surface() {
    const surface = (this.idRate / 100) * this.cif;
    return surface;
  }

  get etls() {
    const etls = (0.5 / 100) * this.cif;
    return etls;
  }

  get surcharge() {
    const surcharge = (7 / 100) * this.surface;
    return surcharge;
  }

  get levy() {
    const levy = this.lvyRate ? (this.lvyRate / 100) * this.cif : 0;
    return levy;
  }

  get preVatTotal() {
    return (
      this.cif +
      this.ciss +
      this.surface +
      this.etls +
      this.surcharge +
      this.levy
    );
  }

  get vat() {
    return this.vatRate ? (this.vatRate / 100) * this.preVatTotal : 0;
  }

  get total() {
    return (
      this.ciss +
      this.surface +
      this.etls +
      this.surcharge +
      this.levy +
      this.vat
    );
  }

  get currenciesAndRates() {
    return this.currencies;
  }

  get currencyList() {
    return Object.keys(this.currenciesRatesObj).join(', ');
  }

  <template>
    <div class="duty-container">
    <div>
      <h1 class='form form-header'>Estimated Duty</h1>
    </div>
    <div class="table-wrapper">
      <table class='pure-table pure-table-bordered brand-text dutyEstimated'>
        <tr>
          <td>CISS</td>
          <td>{{numFormatter this.ciss}}</td>
        </tr>
        <tr>
          <td>Surface Duty</td>
          <td>{{numFormatter this.surface}}</td>
        </tr>
        <tr>
          <td>ETLS</td>
          <td>{{numFormatter this.etls}}</td>
        </tr>
        <tr>
          <td>Surcharge</td>
          <td>{{numFormatter this.surcharge}}</td>
        </tr>
        <tr>
          <td>Levy</td>
          <td>{{numFormatter this.levy}}</td>
        </tr>
        <tr>
          <td>VAT</td>
          <td>{{numFormatter this.vat}}</td>
        </tr>
        <tr>
          <td>Total</td>
          <td>{{numFormatter this.total}}</td>
        </tr>
      </table>
    </div>
    <div class='dutyNoteText'>
      <p><b>Note:</b> <br />
         The exchange {{if this.numberOfCurrencies "rates" "rate"}} used to convert {{this.currencyList}}
         to NGN {{if this.numberOfCurrencies "are" "is"}} obtained from NCS website.
         The {{if this.numberOfCurrencies "rates" "rate"}} {{if this.numberOfCurrencies "are" "is"}} as follows:
      </p>
      <ul>
      {{#each this.currencies as |currency|}}
        <li> {{currency.code}}1 to NGN{{currency.rate}}</li>
      {{/each}}
      </ul>
    </div>
    </div>
    <style>
      .dutyEstimated tr td:last-child {
        text-align: right;
        padding-right: 20%;
        min-width: 12rem;
      }
      .dutyEstimated tr:last-child {
        font-weight: 800;
      }

      .dutyEstimated tr:nth-last-child(odd) {
        background-color: white;
      }
      .duty-container {
        display: grid;
        justify-content: center;
      }
      .table-wrapper {
        display: grid;
        justify-content: center;
      }
      .dutyNoteText {
        margin-top: 1rem;
        padding: 0.4rem;
        font-size: 0.7rem;
        font-family: Lato;
        background-color: #cfecf7;
      }
    </style>
  </template>
}
