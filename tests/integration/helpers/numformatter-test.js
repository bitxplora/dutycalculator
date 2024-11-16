import { module, test } from 'qunit';
import { setupRenderingTest } from 'dutycalculator/tests/helpers';
import numFormatter from 'dutycalculator/helpers/numFormatter';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Helper | numFormatter', function (hooks) {
  setupRenderingTest(hooks);

  test('should add commas seperator to string of number', async function (assert) {
    this.set('inputValue', '1234');

    await render(hbs`{{ numFormatter this.inputValue }}`);

    assert.dom().hasText('1,234.00');
  });
});
