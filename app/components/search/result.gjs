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
          Please double-click on the most appropriate description that best matches your item
        </caption>
        <thead>
          <tr class="table-head">
            <th>HS Code</th>
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
     #caption-message {
       color: #003e57;
       font-style: oblique;
       font-size: 0.9rem;
       font-weight: 700;
       font-family: 'Roboto Slab';
      }
      .table-head > th:nth-child(2) {
       min-width: 200px;
      }
    .result-component {
      margin-top: 5%;
    }
     .table-head > th:last-of-type {
       display: flex;
       place-content: center;
    }
    tbody.hover-effect {
      color: #ccf0ff;
    }
    tbody.hover-effect tr:hover {
      background-color: #b9e3f3;
    }
    tbody.hover-effect {
      font-family: Lato;
      font-size: 0.85rem;
      font-weight: 560;
      letter-spacing: 0.1rem;
      color: #00161f;
      background-color: #f2fafd;
    }
    .table-head {
      background-color: #003e57;
      color: #ffffff;
      font-size: 0.8rem;
    }
  </style>
</template>
}
