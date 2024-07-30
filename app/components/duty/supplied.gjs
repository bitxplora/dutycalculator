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
    <div class="dutyComponent">
    <div>
      <h2 class='form form-header'>Data</h2>
    </div>
    <table class='pure-table pure-table-bordered brand-text dutySupplied'>
      <tr>
        <td>CET Code</td>
        <td style="min-width:200px">{{this.selectedItem.cetcode}}</td>
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
    </div>
    <style>
      .dutySupplied tr:nth-child(n+1):nth-child(-n+4) > td:nth-child(2) {
        text-align: right;
        padding-right: 30%;
      }
      .dutySupplied tr:nth-child(n+2):nth-child(-n+4) > td:nth-child(2):nth-child(n+2) {
        background-color: #dbf5ff;
        font-weight: 550;
      }
      .dutySupplied {
        background-color: #cfecf7;
      }
      table.dutySupplied > tr td:last-of-type) {
        min-width: 300px;
      }
      .pure-table .dutySupplied > tr:nth-child(1) > td:nth-child(2) {
        min-width: 300px;
      }
      .dutyComponent {
        display: grid;
        justify-content: start;
      }
    </style>
  </template>
}
