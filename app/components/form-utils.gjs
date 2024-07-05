import { concat } from '@ember/helper';

const capitalize = (transactionType) => {
  if (transactionType.toLowerCase() === 'fob') {
    return transactionType.toUpperCase();
  } else {
    return `${transactionType[0].toUpperCase()}${transactionType.slice(1)}`;
  }
};

const Currency = <template>
    <div class="brand-text">
      <label for={{( concat @transactionType "Currency") }}></label>
      <select id={{( concat @transactionType "Currency") }} name={{( concat @transactionType "Currency") }} class="currency-selected" autofocus required>
        <option value=''>CUR</option>
          {{#each @currencies as |currency|}}
            <option id={{currency}} name={{currency}} value={{currency}}>{{currency}}</option>
          {{/each}}
      </select>
    </div>
    <style>
      .currency-selected {
        padding: 0;
        padding-left: 0.3rem;
        font-size: 0.7rem;
        min-height: 2.0rem;
      }
    </style>
</template>

<template>
  <div class="pure-control-group form-row brand-text">
    <label class="" for={{( concat @transactionType "Field")}}>{{capitalize @transactionType}}?</label>
    <Currency @currencies={{@model.currencies}} @transactionType={{@transactionType}} />
    <input type="number" id={{( concat @transactionType "Field")}} name={{( concat @transactionType "Field")}} placeholder="Type the value" required />
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
