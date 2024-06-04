import Route from '@ember/routing/route';

export default class FormRoute extends Route {
  model() {
    return {
      CETcode: 750720000,
      description:
        'This works, but there is a more ergonomic way to do this: grid areas.',
    };
  }
}
