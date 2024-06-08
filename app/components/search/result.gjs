<template>
  <div class='result-component'>
    <table class="pure-table pure-table-bordered">
      <caption id='caption-message'>
        Double click on the most appropriate description that best matches your item
      </caption>
      <thead>
        <tr class="table-head">
          <th>CET Code</th>
          <th>Description</th>
        </tr>
      </thead>
      <tbody class='hover-effect brand-text'>
        {{#let @searchResult as |results|}}
        {{#each results as |result|}}
        <tr>
          <td>{{result.cet_code}}</td>
          <td>{{result.description}}</td>
        </tr>
        {{/each}}
        {{/let}}
      </tbody>
    </table>
  </div>
  <style>
   #caption-message {
      color: var(--accent-color);
     font-size: 1.12rem;
     font-family: var(--info);
    }

  .result-component {
    margin-top: 5%;
  }
  </style>
</template>
