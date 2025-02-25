import ClickOutside from "lib/click_outside"

export default class ToggleSection {
  constructor (target, closingCallback = () => {}) {
    this.closingCallback = closingCallback
    this.target = target
  }

  toggle() {
    const clickOutside = new ClickOutside(this.closeChildren.bind(this), this.target)
    const isChildrenOpened = this.target.classList.contains("opened")
  
    if (isChildrenOpened) {
      clickOutside.endListener()
      this.closingCallback()
    } else {
      clickOutside.startListener()
    }
  
    this.target.classList.toggle("opened")
  }

  closeChildren() {
    this.target.classList.remove("opened")
    this.closingCallback()
  }
}