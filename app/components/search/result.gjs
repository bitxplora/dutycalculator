import Component from '@glimmer/component';
import { on } from '@ember/modifier';
import { action } from '@ember/object';
import { service } from '@ember/service';

export default class SearchResult extends Component {
  @service db;
  @service router;

  @action
  async doSelected(event) {
    const rowTag = event.target.closest('tr');
    if (!rowTag) return false;
    const cetcodeSelected = rowTag.firstElementChild.innerText;
    await this.db.addCetcodeSelected(cetcodeSelected);
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
    .result-component {
      min-width: 300px;
    }
     #caption-message {
       color: var(--accent-color);
       font-size: 0.9rem;
       font-weight: 500;
       font-family: Lato;
      }
    .result-component {
      margin-top: 5%;
    }
     .table-head > th:last-of-type {
       display: flex;
       place-content: center;
    }
    tbody.hover-effect {
      color: 05171f;
    }
    tbody.hover-effect tr:hover {
      background-color: #f2fafd;
    }
    tbody.hover-effect {
      font-family: Lato;
      font-size: 0.9rem;
    }
  </style>
</template>
}
