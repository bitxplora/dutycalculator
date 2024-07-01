import Service from '@ember/service';

export default class DB extends Service {
  searchItem;

  searchedItems;

  server = 'https://10.35.51.85:5000';

  addSearchItem(item) {
    this.searchItem = item;
  }

  async search() {
    const response = await fetch(`${this.server}ngn/items/${this.searchItem}`);
    this.searchedItems = await response.json();
  }

  get searchResult() {
    return this.searchedItems;
  }
}
