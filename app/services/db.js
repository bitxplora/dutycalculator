import Service from '@ember/service';

export default class DB extends Service {
  #server = 'https://10.35.51.85:5000';
  #country = 'ngn';

  #searchItem;
  #selected = {};
  #formData = {};

  addSearchItem(item) {
    this.#searchItem = item;
  }

  addCetcodeSelected(cetcode) {
    this.#selected['cetcode'] = cetcode;
  }

  addDescriptionSelected(description) {
    this.#selected['description'] = description;
  }

  addformData(data) {
    Object.assign(this.#formData, data);
  }

  getSelected() {
    return this.#selected;
  }

  getFormData() {
    return this.#formData;
  }

  async search() {
    const response = await fetch(`
      ${this.#server}/${this.#country}/items/${this.#searchItem}
      `);
    const result = await response.json();

    return result;
  }
}
