import { concat } from '@ember/helper';
import tippyTip from '../modifiers/tippyTip';

const tooltip = (transactionType) => {
  if (transactionType === 'fob') transactionType = 'FOB';
  return `Select the currency in which the ${transactionType} is denominated`;
};

<template>
    <div class="brand-text" >
      <label for={{( concat @transactionType "Currency") }}></label>
      <select
        id={{( concat @transactionType "Currency") }}
        name={{( concat @transactionType "Currency") }}
        class="currency-selected" autofocus="" required=""
        {{tippyTip 'mouseenter' 'top' (tooltip @transactionType)}}>
        <option value=''>CUR</option>
          {{#each @currencies as |currency|}}
            <option id={{currency}} name={{currency}} value={{currency}}>{{currency}}</option>
          {{/each}}
      </select>
    </div>
    <style>
      .currency-selected {
        padding: 0;
        padding-left: 0.1rem;
        font-size: 0.7rem;
        min-height: 2.0rem;
      }
    </style>
</template>
