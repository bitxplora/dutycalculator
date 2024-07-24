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
    <div>
      <Input
        aria-label="Type the name of your item or the tariff code then press enter key"
        placeholder="Search e.g. pipe or 7507200000"
        required="true"
        aria-required="true"
        @type="search"
        @value={{this.query}}
        {{on "keyup" this.doSearch}}
      />
    </div>
  </template>
}
