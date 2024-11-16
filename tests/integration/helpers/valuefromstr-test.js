import { module, test } from 'qunit';
import { setupRenderingTest } from 'dutycalculator/tests/helpers';
import valueFromStr from 'dutycalculator/helpers/valueFromStr';
import { render } from '@ember/test-helpers';
import { hbs } from 'ember-cli-htmlbars';

module('Integration | Helper | valuefromstr', function (hooks) {
  setupRenderingTest(hooks);

  test('remove commas from string of number', async function (assert) {
    this.set('inputValue', '1,234,567');

    await render(hbs`{{valueFromStr this.inputValue}}`);

    assert.dom().hasText('1234567');
  });
});
