const capitalize = (transactionType) => {
  if (transactionType.toLowerCase() === 'fob') {
    return transactionType.toUpperCase();
  } else {
    return `${transactionType[0].toUpperCase()}${transactionType.slice(1)}`;
  }
};

const Currency = <template>
    <div class="brand-text">
      <label for="currency-selected"></label>
      <select id="currency-selected" autofocus required>
        <option value=''>CUR</option>
          {{#each @currencies as |currency|}}
            <option id={{currency}} name={{currency}} value={{currency}}>{{currency}}</option>
          {{/each}}
      </select>
    </div>
    <style>
      #currency-selected {
        padding: 0;
        padding-left: 0.3rem;
        font-size: 0.7rem;
        min-height: 2.0rem;
      }
    </style>
</template>

const Field = <template>
  <div class="pure-control-group form-row brand-text">
    <label class="" for={{@transactionType}}>{{capitalize @transactionType}}?</label>
    <Currency @currencies={{@model.currencies}} />
    <input type="number" id={{@transactionType}} name={{@transactionType}} placeholder="Type the value" required />
  </div>
  <style>
    .form-row {
      display: flex;
      align-items: baseline;
      justify-content: flex-end;
      gap: 0.2rem;
      // font-family: Lato;
    }

  .form-row input {
    width: 14rem;
  }

  @media only screen and (min-width: 430px) {
    .form-row input {
      width: 20rem;
    }
  }
  </style>
</template>

  <template>
    <div class="form-position">
      <h5 class="form-subtitle">Fill the below</h5>
      <form class="pure-form pure-form-aligned">
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
