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

  <template>
    <table class='pure-table pure-table-bordered brand-text dutySupplied'>
      <tr>
        <td>CET Code</td>
        <td>{{this.selectedItem.cetcode}}</td>
      </tr>
      <tr>
        <td>FOB</td>
        <td>{{numFormatter this.formData.fobField}}</td>
      </tr>
      <tr>
        <td>Freight</td>
        <td>{{numFormatter this.formData.freightField}}</td>
      </tr>
      <tr>
        <td>Insurance</td>
        <td>{{numFormatter this.formData.insuranceField}}</td>
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
