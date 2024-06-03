import EmberRouter from '@ember/routing/router';
import config from 'dutycalculator/config/environment';

export default class Router extends EmberRouter {
  location = config.locationType;
  rootURL = config.rootURL;
}

Router.map(function () {
  this.route('search-result');
  this.route('form');
  this.route('not-found', { path: '/*path' });
});
