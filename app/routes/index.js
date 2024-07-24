import Route from '@ember/routing/route';

export default class extends Route {
  async model() {
    const response = await fetch('https://10.35.51.85:5000/ngn/update');
    const last = await response.json();

    return last;
  }
}
