import Component from '@glimmer/component';
import { service } from '@ember/service';
// import { action } from '@ember/object';

export default class Estimate extends Component {
  @service db;

  #suppliedData;
  #cumstomData;

  #formatter;

  constructor() {
    super(...arguments);
    this.#suppliedData = this.db.getFormData();
    this.#cumstomData = this.db.getSelected();
    this.#formatter = new Intl.NumberFormat('en-US');
  }

  get fob() {
    const fob = Number(this.#suppliedData.fobField);
    return fob;
  }

  get freight() {
    const freight = Number(this.#suppliedData.freightField);
    return freight;
  }

  get insurance() {
    const insurance = Number(this.#suppliedData.insuranceField);
    return insurance;
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
    return this.ciss + this.surface + this.etls + this.surcharge + this.levy;
  }

  get vat() {
    return this.vatRate ? (this.vatRate / 100) * this.preVatTotal : 0;
  }

  get total() {
    return this.preVatTotal + this.vat;
  }

  <template>
    <div>
      <table class='pure-table pure-table-bordered brand-text'>
        <tr>
          <td>CISS</td>
          <td>{{this.ciss}}</td>
        </tr>
        <tr>
          <td>Surface Duty</td>
          <td>{{this.surface}}</td>
        </tr>
        <tr>
          <td>ETLS</td>
          <td>{{this.etls}}</td>
        </tr>
        <tr>
          <td>Surcharge</td>
          <td>{{this.surcharge}}</td>
        </tr>
        <tr>
          <td>Levy</td>
          <td>{{this.levy}}</td>
        </tr>
        <tr>
          <td>VAT</td>
          <td>{{this.vat}}</td>
        </tr>
        <tr>
          <td>Total</td>
          <td>{{this.total}}</td>
        </tr>
      </table>
    </div>
  </template>
}
