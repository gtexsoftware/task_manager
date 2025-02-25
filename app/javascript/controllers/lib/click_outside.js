export default class ClickOutside {
  constructor(callback, target) {
    this.callback = callback
    this.target = target
    this.checkerFunction = this.checker.bind(this)
  }

  startListener() {
    document.addEventListener("click", this.checkerFunction)
  }

  endListener() {
    document.removeEventListener("click", this.checkerFunction)
  }

  checker(event) {
    const isClickedOutside = !this.target.contains(event.target)

    if (isClickedOutside) {
      this.callback()
      this.endListener()
    }
  }
}