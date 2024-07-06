import Component from '@glimmer/component';
import Field from './form-utils';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { on } from '@ember/modifier';

export default class Form extends Component {
  @service db;
  @service router;

  @action
  async doSave(event) {
    event.preventDefault();
    let form = document.getElementById('dutyform');
    let formData = new FormData(form);
    let data = Object.fromEntries(formData.entries());
    await this.db.addFormData(data);
    this.router.transitionTo('duty');
  }

  <template>
    <div class="form-position">
      <h5 class="form-subtitle">Fill the below</h5>
      <form id="dutyform" name="dutyform" class="pure-form pure-form-aligned" {{ on 'submit' this.doSave }}>
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
