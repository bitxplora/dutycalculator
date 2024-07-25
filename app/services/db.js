import Service from '@ember/service';
import valueFromStr from '../helpers/valueFromStr';
// import { hash } from 'rsvp';

export default class DB extends Service {
  server = 'https://10.35.51.85:5000';
  country = 'ngn';

  #searchItem;
  currencies;
  #selected = {};
  formData = {};
  currenciesRatesObj = {};
  fob;
  freight;
  insurance;

  addSearchItem(item) {
    this.#searchItem = item;
  }

  addFormData(data) {
    Object.assign(this.formData, data);
  }

  getSelected() {
    return this.#selected;
  }

  getFormData() {
    return this.formData;
  }

  getCurrencies() {
    return new Set([
      this.formData.fobCurrency,
      this.formData.freightCurrency,
      this.formData.insuranceCurrency,
    ]);
  }

  // async getCurrencyRates() {
  async setCurrenciesAndRates() {
    const params = new URLSearchParams();

    let currencies = this.getCurrencies();

    currencies.forEach((currency) => params.append('currencies', currency));
    const queryString = params.toString();
    const response = await fetch(`
    ${this.server}/${this.country}/exchanges/?${queryString}
      `);

    // const result = await response.json();
    this.currencies = await response.json();
    // console.log(result);

    // return result;
  }

  // get currenciesRates() {
  setCurrenciesRatesObj() {
    const currenciesAndRates = this.currencies;
    for (let entry of currenciesAndRates) {
      let code = entry['code'];
      let rate = entry['rate'];
      this.currenciesRatesObj[code] = rate;
    }
  }

  getCurrenciesAndRates() {
    return this.currencies;
  }

  getCurrenciesRatesObj() {
    return this.currenciesRatesObj;
  }

  async search() {
    const response = await fetch(`
      ${this.server}/${this.country}/items/${this.#searchItem}
      `);
    const result = await response.json();

    // console.log(result);
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
    const fobRaw = Number(valueFromStr(this.formData.fobField));
    const fobCurrencyCode = this.formData.fobCurrency;
    const fobCurrencyRate = this.currenciesRatesObj[fobCurrencyCode];
    return fobRaw * fobCurrencyRate;
  }

  /**
   * Calculate the freight value at the official exchange rate
   */
  getFreight() {
    const freightRaw = Number(valueFromStr(this.formData.freightField));
    const freightCurrencyCode = this.formData.freightCurrency;
    const freightCurrencyRate = this.currenciesRatesObj[freightCurrencyCode];
    return freightRaw * freightCurrencyRate;
  }

  /**
   * Calculate the insurance value at the official exchange rate
   */
  getInsurance() {
    const insuranceRaw = Number(valueFromStr(this.formData.insuranceField));
    const insuranceCurCode = this.formData.insuranceCurrency;
    const insuranceCurRate = this.currenciesRatesObj[insuranceCurCode];
    return insuranceRaw * insuranceCurRate;
  }
}
