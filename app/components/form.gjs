import Component from '@glimmer/component';
import Field from './form-utils';
import { service } from '@ember/service';

export default class Form extends Component {
  @service db;

  <template>
    <div class="form-position">
      <h5 class="form-subtitle">Fill the below</h5>
      <form id="dutyform" name="dutyform" class="pure-form pure-form-aligned">
      <fieldset class='field-position'>
        <legend class="pure-form-message">For each row, select the appropriate currency and input the value.</legend>
        <div class="fields-group">
          <div>
            <Field @model={{@model}} @transactionType='fob' />
            <Field @model={{@model}} @transactionType='freight' />
            <Field @model={{@model}} @transactionType='insurance' />
          </div>
          <div>
            <button type="submit" class="pure-button pure-button-primary">Submit</button>
          </div>
        </div>
      </fieldset>
      </form>
    </div>
    <style>
      .pure-form-aligned .pure-control-group label {
        width: fit-content;
      }

      .fields-group {
        display: flex;
        flex-direction: column;
        align-items: start;
      }

      .form-position {
        margin-top: 15%;
        display: grid;
        justify-content: space-around;
      }
    </style>
  </template>
}
