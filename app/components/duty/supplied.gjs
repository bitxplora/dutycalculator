import Component from '@glimmer/component';
import { service } from '@ember/service';

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
    <table class='pure-table pure-table-bordered brand-text'>
      <tr>
        <td>CET Code</td>
        <td>{{this.selectedItem.cetcode}}</td>
      </tr>
      <tr>
        <td>FOB</td>
        <td>{{this.formData.fobField}}</td>
      </tr>
      <tr>
        <td>Freight</td>
        <td>{{this.formData.freightField}}</td>
      </tr>
      <tr>
        <td>Insurance</td>
        <td>{{this.formData.insuranceField}}</td>
      </tr>
      <tr>
        <td>Discription</td>
        <td>{{this.selectedItem.description}}</td>
      </tr>
    </table>
  </template>
}
