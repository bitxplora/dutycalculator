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
    <div>
      <h1 class='form form-header'>Data Supplied</h1>
    </div>
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
      .dutySupplied > tr:nth-child(1) > td:nth-child(2) {
        // text-align: center;
      }
      .dutySupplied tr:nth-child(n+1):nth-child(-n+4) > td:nth-child(2) {
        text-align: right;
        padding-right: 20%;
        // background-color: #dbf5ff;
      }
      .dutySupplied tr:nth-child(n+2):nth-child(-n+4) > td:nth-child(2):nth-child(n+2) {
        background-color: #dbf5ff;
      }
      .dutySupplied {
        background-color: #cfecf7;
      }
    </style>
  </template>
}
