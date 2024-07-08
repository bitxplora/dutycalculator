import Component from '@glimmer/component';
import { concat } from '@ember/helper';
import { on } from '@ember/modifier';
import Currency from './currency';

export default class Field extends Component {
  capitalize(transactionType) {
    if (transactionType.toLowerCase() === 'fob') {
      return transactionType.toUpperCase();
    } else {
      return `${transactionType[0].toUpperCase()}${transactionType.slice(1)}`;
    }
  }

  doFormat(event) {
    let userValue = event.target.value;
    //
    // Remove non-digit except for decimal point
    let cleanedValue = userValue.replace(/[^\d.]/g, '');
    //
    // Splite the value on the decimal, if present
    let parts = cleanedValue.split('.');
    //
    // Format the integer part with commas
    parts[0] = parts[0].replace(/\B(?=(\d{3})+(?!\d))/g, `,`);
    // Remove leading zero
    parts[0] = parts[0].replace(/^0+(?!\.)/, '');
    // parts[0] = parts[0].replace(/^0+/, '');
    //
    // Rejoin the integer and decimal, and re-assign to evet.target.value
    event.target.value = parts.join('.');
  }

  <template>
    <div class="pure-control-group form-row brand-text" >
      <label class="" for={{( concat @transactionType "Field")}}>{{this.capitalize @transactionType}}?</label>
      <Currency @currencies={{@model.currencies}} @transactionType={{@transactionType}} />
      <div {{on 'input' this.doFormat}}>
        <input type="text" id={{( concat @transactionType "Field")}} name={{( concat @transactionType "Field")}} placeholder="Type the value" required />
      </div>
    </div>
    <style>
      .form-row {
        display: flex;
        align-items: baseline;
        justify-content: flex-end;
        gap: 0.2rem;
        // font-family: Lato;
      }

    .form-row input {
      width: 14rem;
    }

    @media only screen and (min-width: 430px) {
      .form-row input {
        width: 20rem;
      }
    }
    </style>
  </template>
}
