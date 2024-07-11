import tippyTip from '../modifiers/tippyTip.js';

<template>
  <div class="center-display disclaimer">
    <div>
      <h4 {{
        tippyTip 'click' 'top'
          'This web application was created to assist importers and others in estimating duty charges. We are not associated with NCS.'
          }}
        >
        Disclaimer
      </h4>
    </div>
    <div>
    </div>
  </div>
</template>
