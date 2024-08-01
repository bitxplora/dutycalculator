import Component from '@glimmer/component';
import { service } from '@ember/service';
import numFormatter from '../../helpers/numFormatter';

export default class Estimate extends Component {
  @service db;

  #suppliedData;
  #cumstomData;

  constructor() {
    super(...arguments);
    this.#suppliedData = this.db.getFormData();
    this.#cumstomData = this.db.getSelected();
  }

  get fob() {
    const fobValue = this.db.getFob();
    if (!fobValue) return 0;
    return fobValue;
  }

  /* Retrieved and returned Freight value from DB service */
  get freight() {
    const freightValue = this.db.getFreight();
    if (!freightValue) return 0;
    return freightValue;
  }

  /* Retrieved and returned Insurance value from DB service */
  get insurance() {
    const insuranceValue = this.db.getInsurance();
    if (!insuranceValue) return 0;
    return insuranceValue;
  }

  get vatRate() {
    const vat = Number(this.#cumstomData.vat);
    if (!vat) return 0;
    return vat;
  }

  get idRate() {
    const id = Number(this.#cumstomData.id);
    if (!id) return 0;
    return id;
  }

  get lvyRate() {
    const lvy = Number(this.#cumstomData.lvy);
    if (!lvy) return 0;
    return lvy;
  }

  get cif() {
    const cif = this.fob + this.freight + this.insurance;
    if (!cif) return 0;
    return cif;
  }

  get ciss() {
    const ciss = (1 / 100) * this.fob;
    if (!ciss) return 0;
    return ciss;
  }

  get surface() {
    const surface = (this.idRate / 100) * this.cif;
    if (!surface) return 0;
    return surface;
  }

  get etls() {
    const etls = (0.5 / 100) * this.cif;
    if (!etls) return 0;
    return etls;
  }

  get surcharge() {
    const surcharge = (7 / 100) * this.surface;
    if (!surcharge) return 0;
    return surcharge;
  }

  get levy() {
    const levy = this.lvyRate ? (this.lvyRate / 100) * this.cif : 0;
    if (!levy) return 0;
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

  <template>
    <div class="duty-container">
      <h2 class='form form-header'>Duty</h2>
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
        width: 50%;
        margin-top: 2rem;
        display: grid;
      }
      .table-wrapper {
        display: grid;
        justify-content: center;
        justify-items: center;
      }
    </style>
  </template>
}
