import Component from '@glimmer/component';
import { service } from '@ember/service';
import numFormatter from '../../helpers/numFormatter.js';

export default class Supplied extends Component {
  @service db;

  #selectedItem;
  #formData;

  constructor() {
    super(...arguments);
    this.selectedItem = this.db.getSelected();
    this.formData = this.db.getFormData();
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

  <template>
    <table class='pure-table pure-table-bordered brand-text dutySupplied'>
      <tr>
        <td>CET Code</td>
        <td>{{this.selectedItem.cetcode}}</td>
      </tr>
      <tr>
        <td>FOB</td>
        <td>{{numFormatter this.fob}}</td>
      </tr>
      <tr>
        <td>Freight</td>
        <td>{{numFormatter this.freight}}</td>
      </tr>
      <tr>
        <td>Insurance</td>
        <td>{{numFormatter this.insurance}}</td>
      </tr>
      <tr>
        <td>Discription</td>
        <td>{{this.selectedItem.description}}</td>
      </tr>
    </table>
    <style>
      .dutySupplied tr td:nth-child(-n + 4):last-child {
        text-align: center;
      }
    </style>
  </template>
}
