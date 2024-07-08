import { concat } from '@ember/helper';

<template>
    <div class="brand-text">
      <label for={{( concat @transactionType "Currency") }}></label>
      <select id={{( concat @transactionType "Currency") }} name={{( concat @transactionType "Currency") }} class="currency-selected" autofocus="" required="">
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
