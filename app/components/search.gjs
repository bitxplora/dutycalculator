import Component from '@glimmer/component';
import { Input } from '@ember/component';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import tippyTip from '../modifiers/tippyTip.js';

export default class Search extends Component {
  @service router;
  @service db;

  @tracked query = '';
  @tracked error = false;

  async search() {
    this.db.addSearchItem(this.query);
    const result = await this.db.search();
    if (result.length === 0) {
      this.error = true;
      return false;
    }
    this.router.transitionTo('search-result');
  }

  @action doSearch(event) {
    if (event.key === 'Enter') {
      if (!this.query) return false;
      this.search();
    }
  }

  @action doRefresh() {
    if (this.error) {
      this.error = false;
    }
  }

  @action goSearch() {
    if (!this.query) return false;
    this.search();
  }

  <template>
    {{#if this.error}}
    <div class="error">
      <p>
        The item <b>{{this.query}}</b> is not found in the NCS' CET tariff section!
      </p>
    </div>
    {{/if}}
    <div class='searchcomponent'>
      <Input
        aria-label="Type the name of your item or the tariff code then press enter key"
        required="true"
        aria-required="true"
        placeholder=" Search for the item or HS code"
        @type="search"
        @value={{this.query}}
        {{on "input" this.doRefresh}}
        {{on "keyup" this.doSearch}}
        {{tippyTip 'click' 'top'
           "To get started, please enter the item's name (like 'pipe') or use the HS code (for example, '750720000') to search."
        }}
      />
      <button class="searchbutton" name="search-go" value={{this.query}} type="submit" {{on "click" this.goSearch}}>
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
        border-width: 0.3rem 0.3rem 0.3rem 0.15rem;
        border-color: var(--title-color);
      }
      input[type=search] {
        font-family: 'Roboto Mono';
        font-size: 65%;
        font-weight: 900;
        text-align: left;
      }
      .searchbox {
        width: 100%;
      }
      .searchbox input {
        height: 2.5rem;
        width: 100%;
        border-style: solid;
        border-width: 0.3rem 0.15rem 0.3rem 0.3rem;
        background-color: #ffffff;
        color: #05171f;
        border-radius: 0.4rem 0rem 0rem 0.4rem;
      }
      .searchcomponent input {
        margin: 0;
        padding: 0;
      }
      .searchcomponent {
        width: 100%;
        display: flex;
        place-content: center;
        place-items: center;
      }
      .error {
        display: flex;
        place-content: center;
      }
      .error p {
        padding: 0.6rem;
        width: content-fit;
        background-color: #ffcddf;
        color: #330113;
        margin-bottom: 0.3rem;
        border-radius: 0.3rem;
        font-size: 0.85rem;
        font-weight: 500;
        font-family: Lato;
      }
      </style>
    </div>
  </template>
}
