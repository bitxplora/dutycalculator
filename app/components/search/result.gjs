import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class SearchResult extends Component {
  @service db;
  @service router;

  @action
  doSelected(event) {
    const rowTag = event.target.closest('tr');
    if (!rowTag) return false;
    const cetcodeSelected = rowTag.firstElementChild.innerText;
    const descriptionSelected = rowTag.lastElementChild.innerText;
    this.db.cetcodeSelected(cetcodeSelected);
    this.db.descriptionSelected(descriptionSelected);
    this.router.transitionTo('form');
  }

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
        <tbody class='hover-effect brand-text' {{on 'dblclick' this.doSelected}}>
          {{log @searchResult}}
          {{#let @searchResult as |results|}}
          {{#each results as |result|}}
          <tr>
            <td>{{result.cetcode}}</td>
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
}
