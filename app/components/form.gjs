const capitalize = (transactionType) => {
  if (transactionType.toLowerCase() === 'fob') {
    return transactionType.toUpperCase();
  } else {
    return `${transactionType[0].toUpperCase()}${transactionType.slice(1)}`;
  }
};

const Currency = <template>
    <div class="pure-u-2-24 push-left">
      <label for="currency-selected"></label>
      <select id="currency-selected">
        <option>CUR</option>
        <option>NGN</option>
        <option>USD</option>
        <option>YEN</option>
      </select>
    </div>
    <style>
      #currency-selected {
        padding: 0;
        padding-left: 0.3rem;
        font-size: 0.7rem;
        min-height: 2.0rem;
      }

      .push-left {
        margin-left: auto;
        display: flex;
        align-content: center;
      }
    </style>
</template>

const Field = <template>
  <div class="pure-control-group form-row pure-g">
    <label class="pure-u-2-24" for={{@transactionType}}>{{capitalize @transactionType}}?</label>
    <Currency />
    <input class="pure-u-14-24 input-space" type="text" id={{@transactionType}} name="" placeholder="Value" required="" />
  </div>
  <style>
    .input-space {
      margin: 0;
      margin-left: 1.5rem;
      padding: 0;
      box-sizing: border-box;
    }

    .form-row {
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 0.1rem;
    }
  </style>
</template>

  <template>
    <div>
      <h4 class="center-display">Fill in the below:</h4>
      <form class="pure-form pure-form-aligned center-display">
      <fieldset>
        <legend class="pure-form-message">For each row, select the appropriate currency and input the value.</legend>
        <Field @transactionType='fob' />
        <Field @transactionType='freight' />
        <Field @transactionType='insurance' />
        <div class="center-display">
          <button type="submit" class="pure-button pure-button-primary">Submit</button>
        </div>
      </fieldset>
      </form>
    </div>
    <style>
      .pure-form-aligned .pure-control-group label {
        margin: 0;
        width: fit-content;
      }
    </style>
  </template>
