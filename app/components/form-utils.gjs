import Component from '@glimmer/component';
import { concat } from '@ember/helper';
import { on } from '@ember/modifier';
import Currency from './currency';
import tippyTip from '../modifiers/tippyTip';
import { fn } from '@ember/helper';

export default class Field extends Component {
  messages = {
    fob: 'FOB means Free On Board. The value of the goods at origin port',
    freight:
      'The cost of shipping from the origin port to the destination port',
    insurance: 'The cost of insurance for the goods',
  };

  capitalize(transactionType) {
    if (transactionType.toLowerCase() === 'fob') {
      return transactionType.toUpperCase();
    } else {
      return `${transactionType[0].toUpperCase()}${transactionType.slice(1)}`;
    }
  }

  tooltipMessage = (transactionType) => {
    if (transactionType === 'fob') {
      return this.messages.fob;
    } else if (transactionType == 'freight') {
      return this.messages.freight;
    } else if (transactionType === 'insurance') {
      return this.messages.insurance;
    }
  };

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
      {{#let (fn this.tooltipMessage @transactionType) as |message|}}
        <label
          for={{( concat @transactionType "Field")}}
          {{tippyTip 'mouseenter' 'right' message }}
          >
          {{this.capitalize @transactionType}}?
        </label>
      {{/let}}
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
