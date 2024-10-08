import tippyTip from '../modifiers/tippyTip.js';

<template>
  <div class="disclaimer">
      <p role="button" {{
            tippyTip 'mouseover' 'top'
            'This web application was created to assist importers and others in estimating duty charges. We are not associated with NCS.'
          }}
        >
        Disclaimer
      </p>
  </div>
  <style>
    .disclaimer {
      padding-top: 2rem;
      display: flex;
      place-content: center;
      font-size: 0.9rem;
      color: var(--accent-color);
      font-family: var(--info);
      font-weight: 900;
      letter-spacing: 0.25rem;
    }
    </style>
</template>
