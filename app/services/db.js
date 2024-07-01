import Service from '@ember/service';

export default class DB extends Service {
  searchItem;

  addSearchItem(item) {
    this.searchItem = item;
  }
}
