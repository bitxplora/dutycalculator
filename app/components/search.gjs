import Component from '@glimmer/component';
import { Input } from '@ember/component';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class Search extends Component {
  @service router;
  @service db;

  @tracked query = '';

  @action doSearch(event) {
    if (event.key === 'Enter') {
      if (!this.query) return false;

      this.db.addSearchItem(this.query);
      this.router.transitionTo('search-result');
    }
  }

  <template>
    <div class='searchcomponent'>
      <Input
        aria-label="Type the name of your item or the tariff code then press enter key"
        placeholder=" Search the item e.g. pipe or 7507200000"
        required="true"
        aria-required="true"
        @type="search"
        @value={{this.query}}
        {{on "keyup" this.doSearch}}
      />
      <button class="searchbutton" type="submit">
        Go
      </button>
      <style>
      .searchbutton {
        height: 2.5rem;
        width: 2.5rem;
        background-color: var(--title-color);
        color: #ffffff;
        font-weight: 900;
        font-size: 1.2rem;
        border-radius: 0rem 0.4rem 0.4rem 0rem;
        padding: 0;
        font-family: Montserrat;
        border-style: solid;
        border-width: 0.3rem;
        border-color: var(--title-color);
      }
      input[type=search] {
        font-family: Lato;
        font-size: 1.0rem;
        font-weight: 800;
        text-align: left;
      }

      .searchbox input {
        height: 2.5rem;
        width: 20rem;
        border-style: solid;
        border-width: 0.3rem;
        background-color: #ffffff;
        color: #05171f;
        border-radius: 0.4rem 0rem 0rem 0.4rem;
      }
      .searchcomponent input {
        margin: 0;
        padding: 0;
      }
      .searchcomponent {
        margin-top: 2rem;
        display: flex;
        place-content: center;
        place-items: center;
      }
      </style>
    </div>
  </template>
}
