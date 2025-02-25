export default class FocusTrap {
  constructor(wrapper) {
    this.wrapper = wrapper
    this.focusableElements = wrapper.querySelectorAll('a[href]:not([disabled]), button:not([disabled]), textarea:not([disabled]), input[type="text"]:not([disabled]), input[type="radio"]:not([disabled]), input[type="checkbox"]:not([disabled]), select:not([disabled])')
    this.firstFocusableElement = this.focusableElements[0]
    this.lastFocusableEl = this.focusableElements[this.focusableElements.length - 1];
  }

  startListener() {
    this.wrapper.addEventListener('keydown', this.trapFocus.bind(this))
  }

  endListener() {
    this.wrapper.removeEventListener('keydown', this.trapFocus.bind(this))
  }

  trapFocus(e) {
    const KEYCODE_TAB = 9;

    if (e.key === 'Tab' || e.keyCode === KEYCODE_TAB) {
      if (e.shiftKey) {
        if (document.activeElement === this.firstFocusableElement) {
          this.lastFocusableEl.focus();
          e.preventDefault();
        }
      } else {
        if (document.activeElement === this.lastFocusableEl) {
          this.firstFocusableElement.focus();
          e.preventDefault();
        }
      }
    }
  }
}