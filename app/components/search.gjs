import Component from '@glimmer/component';
import { Input } from '@ember/component';
import { on } from '@ember/modifier';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';

export default class SearchComponent extends Component {
  @service router;

  @tracked query = '';

  @action doSearch(event) {
    if (event.key === 'Enter') {
      this.query = event.target.value;
      this.router.transitionTo('search-result');
    }
  }

  <template>
    <div>
      <Input
        aria-label="Type the name of your item or the tariff code then press enter key"
        placeholder="Type the name or tariff code then Enter"
        @type="search"
        @value={{this.query}}
        {{on "keydown" this.doSearch}}
      />
    </div>
  </template>
}
