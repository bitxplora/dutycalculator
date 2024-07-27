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
    await this.db.setCurrenciesAndRates();
    await this.db.setCurrenciesRatesObj();
    this.router.transitionTo('duty');
  }

  <template>
    <div class="form-position">
      <h2 class="form-subtitle">Fill the below:</h2>
      <form id="dutyform" name="dutyform" class="pure-form pure-form-aligned" {{ on 'submit' this.doSave }}>
      <fieldset class='field-position'>
        <legend class="pure-form-message">For each row, select the appropriate currency and input the value.</legend>
        <div class="fields-group">
            <Field @model={{@model}} @transactionType='fob' />
            <Field @model={{@model}} @transactionType='freight' />
            <Field @model={{@model}} @transactionType='insurance' />
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
        display: grid;
        font-family: Lato;
      }
      .fields-group label > .pure-form-aligned .pure-control-group label {
        margin: 0;
      }

      .form-position {
        margin-top: 1.2rem;
        display: grid;
        justify-content: space-around;
      }
      h2.form-subtitle {
        font-size: 1.0rem;
        font-weight: 400;
        letter-spacing: 0.1rem;
        color: var(--title-color);
        font-family: var(--title);
        margin-bottom: 0.4rem;
      }
    </style>
  </template>
}
