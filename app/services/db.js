import Service from '@ember/service';

export default class DB extends Service {
  searchItem;

  searchedItems;

  server = 'https://10.35.51.85:5000';

  addSearchItem(item) {
    this.searchItem = item;
  }

  async search() {
    const response = await fetch(`${this.server}/ngn/items/${this.searchItem}`);
    const result = await response.json();

    return result;
  }
}
