import Service from '@ember/service';
import valueFromStr from '../helpers/valueFromStr';

/**
 * Calculate the freight value at the official exchange rate
 */
export default class DB extends Service {
  server = 'https://10.35.51.85:5000';
  country = 'ngn'; // The currency code serves as the route for each country.

  #searchItem; // The item searched by the user.
  #currencies; // Array of object currency containing: code, name and rate.
  #selected = {}; // Object containing the row selected by the user by double-click.
  #formData = {}; // Object containing form data; fobCurrency, fobField, freight, insurance
  #currenciesRatesObj = {}; // Object containing currency code and rate for the once used in form { ILS: 388.34, INR: 17.841, JPY: 9.576 }

  /**
   * Calculate the freight value at the official exchange rate
   */
  addSearchItem(item) {
    this.#searchItem = item;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  addFormData(data) {
    Object.assign(this.#formData, data);
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getSelected() {
    return this.#selected;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getFormData() {
    return this.#formData;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getCurrencies() {
    return new Set([
      this.#formData.fobCurrency,
      this.#formData.freightCurrency,
      this.#formData.insuranceCurrency,
    ]);
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
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

  /**
   * Calculate the freight value at the official exchange rate
   */
  setCurrenciesRatesObj() {
    const currenciesAndRates = this.#currencies;
    for (let entry of currenciesAndRates) {
      let code = entry['code'];
      let rate = entry['rate'];
      this.#currenciesRatesObj[code] = rate;
    }
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getCurrenciesAndRates() {
    return this.#currencies;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getCurrenciesRatesObj() {
    return this.#currenciesRatesObj;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  async search() {
    const response = await fetch(`
      ${this.server}/${this.country}/items/${this.#searchItem}
      `);
    const result = await response.json();

    return result;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  async getCurrencyCodes() {
    const response = await fetch(`
      ${this.server}/${this.country}/currency/codes
      `);
    const result = await response.json();
    return result;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  async addCetcodeSelected(cetcode) {
    const response = await fetch(`
      ${this.server}/${this.country}/items/${cetcode}
      `);
    const result = await response.json();

    Object.assign(this.#selected, result[0]);
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getFob() {
    const fobRaw = Number(valueFromStr(this.#formData.fobField));
    const fobCurrencyCode = this.#formData.fobCurrency;
    const fobCurrencyRate = this.#currenciesRatesObj[fobCurrencyCode];
    return fobRaw * fobCurrencyRate;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getFreight() {
    const freightRaw = Number(valueFromStr(this.#formData.freightField));
    const freightCurrencyCode = this.#formData.freightCurrency;
    const freightCurrencyRate = this.#currenciesRatesObj[freightCurrencyCode];
    return freightRaw * freightCurrencyRate;
  }

  /**
   * Calculate the insurance value at the official exchange rate
   */
  getInsurance() {
    const insuranceRaw = Number(valueFromStr(this.#formData.insuranceField));
    const insuranceCurCode = this.#formData.insuranceCurrency;
    const insuranceCurRate = this.#currenciesRatesObj[insuranceCurCode];
    return insuranceRaw * insuranceCurRate;
  }
}
