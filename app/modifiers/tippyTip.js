import { modifier } from 'ember-modifier';
import tippy from 'tippy.js';
import 'tippy.js/dist/tippy.css';
import 'tippy.js/dist/backdrop.css';
import 'tippy.js/themes/light.css';
import 'tippy.js/themes/material.css';
import 'tippy.js/themes/translucent.css';
import 'tippy.js/animations/scale.css';

/*
 *
 * This modifier enables adding of tooltip to any element.
 *
 * @param {HTMLElement} element - This is the element on wish the modifier is
 *                 applied, it is the default, it is not needed to be supplied.
 *                 Default to the element the modifier is applied on.
 * @param {[Event]} trigger - The that must happened for this effect to happen. Required
 * @param {[Placement]} position - It is where the tooltip be placed. Required,
 *                  default to top, consult tippy.js for other options.
 * @param {[Tip]} message - It is tips that will be displayed. Required.
 * @param {[Props]} tippyOptions - It is object of props, for customisation of behavior. Optional.
 * @return a teardown callback, that removes the tooltip from the element.
 *
 * example {{tippyTip 'click' 'right' 'I am a tooltip!' {theme: 'customised'}}}
 *
 */
export default modifier(
  (element, [trigger, position, message, tippyOptions]) => {
    const defaultOptions = {
      content: message,
      trigger: trigger,
      placement: position,
      theme: 'tippyTheme',
      animateFill: true,
      inertia: true,
      animation: 'scale',
    };

    const tippyRef = tippy(element, { ...defaultOptions, ...tippyOptions });

    return () => {
      tippyRef?.destroy();
    };
  },
);
