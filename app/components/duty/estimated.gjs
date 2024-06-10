import Component from '@glimmer/component';

export default class Estimate extends Component {
  ciss = () => 2333028101;
  etls = () => 2333028101;
  surcharge = () => 2333028101;
  levy = () => 2333028101;
  vat = () => 2333028101;
  total = () => 2333028101;

  <template>
    <div>
      <table class='pure-table pure-table-bordered brand-text'>
        <tr>
          <td>CISS</td>
          <td>{{this.ciss}}</td>
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
