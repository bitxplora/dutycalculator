import Service from '@ember/service';

export default class DB extends Service {
  server = 'https://10.35.51.85:5000';
  country = 'ngn';

  searchedItems;
  #selected = {};

  addSearchItem(item) {
    this.searchItem = item;
  }

  set cetcodeSelected(cetcode) {
    this.#selected['cetcode'] = cetcode;
  }

  set descriptionSelected(description) {
    this.#selected['description'] = description;
  }

  get selected() {
    return this.#selected;
  }

  async search() {
    const response = await fetch(`
      ${this.server}/${this.country}/items/${this.searchItem}
      `);
    const result = await response.json();

    return result;
  }
}
