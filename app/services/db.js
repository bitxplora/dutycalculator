import Service from '@ember/service';
import valueFromStr from '../helpers/valueFromStr';

export default class DB extends Service {
  // server = 'https://10.35.51.85:5000';
  server = 'https://10.35.51.193:5000';
  country = 'ngn'; // The currency code serves as the route for each country.

  #searchItem; // The item searched by the user.
  #currencies; // Array of object currency containing: code, name and rate.
  #selected = {}; // Object containing the row selected by the user by double-click.
  #formData = {}; // Object containing form data; fobCurrency, fobField, freight, insurance
  #currenciesRatesObj = {}; // Object containing currency code and rate for the once used in form { ILS: 388.34, INR: 17.841, JPY: 9.576 }

  /**
   * Store the item for to used later.
   * @param item - The item searched by the user in the search bar.
   */
  addSearchItem(item) {
    this.#searchItem = item;
  }

  /**
   * Store FormData from the filled form for later
   * @param data - FormData
   */
  addFormData(data) {
    Object.assign(this.#formData, data);
  }

  getSelected() {
    return this.#selected;
  }

  getFormData() {
    return this.#formData;
  }

  getCurrencies() {
    return new Set([
      this.#formData.fobCurrency,
      this.#formData.freightCurrency,
      this.#formData.insuranceCurrency,
    ]);
  }

  async setCurrenciesAndRates() {
    const params = new URLSearchParams();

    let currencies = this.getCurrencies();

    currencies.forEach((currency) => params.append('currencies', currency));
    const queryString = params.toString();
    const response = await fetch(`
    ${this.server}/${this.country}/exchanges/?${queryString}
      `);

    this.#currencies = await response.json();
  }

  setCurrenciesRatesObj() {
    const currenciesAndRates = this.#currencies;
    for (let entry of currenciesAndRates) {
      let code = entry['code'];
      let rate = entry['rate'];
      this.#currenciesRatesObj[code] = rate;
    }
  }

  getCurrenciesAndRates() {
    return this.#currencies;
  }

  getCurrenciesRatesObj() {
    return this.#currenciesRatesObj;
  }

  async getLastUpdate() {
    const response = await fetch(`${this.server}/${this.country}/update`);
    const last = await response.json();

    return last;
  }

  async search() {
    const response = await fetch(`
      ${this.server}/${this.country}/items/${this.#searchItem}
      `);
    const result = await response.json();

    return result;
  }

  async getCurrencyCodes() {
    const response = await fetch(`
      ${this.server}/${this.country}/currency/codes
      `);
    const result = await response.json();
    return result;
  }

  async addCetcodeSelected(cetcode) {
    const response = await fetch(`
      ${this.server}/${this.country}/items/${cetcode}
      `);
    const result = await response.json();

    Object.assign(this.#selected, result[0]);
  }

  getFob() {
    const fobRaw = Number(valueFromStr(this.#formData.fobField));
    const fobCurrencyCode = this.#formData.fobCurrency;
    const fobCurrencyRate = this.#currenciesRatesObj[fobCurrencyCode];
    return fobRaw * fobCurrencyRate;
  }

  getFreight() {
    const freightRaw = Number(valueFromStr(this.#formData.freightField));
    const freightCurrencyCode = this.#formData.freightCurrency;
    const freightCurrencyRate = this.#currenciesRatesObj[freightCurrencyCode];
    return freightRaw * freightCurrencyRate;
  }

  getInsurance() {
    const insuranceRaw = Number(valueFromStr(this.#formData.insuranceField));
    const insuranceCurCode = this.#formData.insuranceCurrency;
    const insuranceCurRate = this.#currenciesRatesObj[insuranceCurCode];
    return insuranceRaw * insuranceCurRate;
  }
}
