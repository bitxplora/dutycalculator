import { module, test } from 'qunit';
import { setupTest } from 'dutycalculator/tests/helpers';

module('Unit | Service | db', function (hooks) {
  setupTest(hooks);

  test('it exists', function (assert) {
    let service = this.owner.lookup('service:db');
    assert.ok(service);
  });

  test('addSearchItem works', function(assert) {
    const service = this.owner.lookup('service:db');
    assert.deepEqual(service.getItem(), undefined, 'The searchItem is empty');

    service.addSearchItem('tea');
    assert.deepEqual(service.getItem(), 'tea', 'The item search for is "tea".');
  });
});
