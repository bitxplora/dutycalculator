import { modifier } from 'ember-modifier';
import tippy from 'tippy.js';
import 'tippy.js/dist/tippy.css';
import 'tippy.js/dist/backdrop.css';
import 'tippy.js/themes/light.css';
import 'tippy.js/themes/material.css';
import 'tippy.js/themes/translucent.css';
import 'tippy.js/animations/scale.css';

export default modifier(
  (element, [trigger, position, message, tippyOptions]) => {
    const defaultOptions = {
      content: message,
      trigger: trigger,
      placement: position,
      theme: 'tippyTheme',
      inertia: true,
      animation: 'scale',
      maxWidth: 250,
    };

    const tippyRef = tippy(element, { ...defaultOptions, ...tippyOptions });

    return () => {
      tippyRef?.destroy();
    };
  },
);
