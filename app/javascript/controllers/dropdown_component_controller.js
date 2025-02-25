import { Controller } from "@hotwired/stimulus"
import { computePosition, autoUpdate, offset, flip, shift } from "@floating-ui/dom"
import ClickOutside from "./lib/click_outside"

export default class extends Controller {
  static targets = ["trigger", "body"]

  static values = {
    automaticPosition: { type: Boolean, default: true }
  }

  connect() {
    console.log("Dropdown connected")
    this.isOpen = false
    this.clickOutside = null

    this.listenToggleClick()
    this.listenCloseEvent()
  }

  toggle() {
    this.isOpen = !this.isOpen

    if (this.isOpen) {
      this.open()
    } else {
      this.close()
    }

    this.dispatchToggleEvent(this.isOpen)
  }

  open() {
    this.clickOutside = new ClickOutside(this.close.bind(this), this.element)
    this.clickOutside.startListener()

    this.bodyTarget.style.display = "block"
    this.positionDropdown()

    this.cleanup = autoUpdate(this.triggerTarget, this.bodyTarget, () => this.positionDropdown())
  }

  close() {
    this.bodyTarget.style.display = "none"

    if (this.cleanup) this.cleanup()

    if (this.clickOutside) {
      this.clickOutside.endListener()
      this.clickOutside = null
    }

    this.isOpen = false
  }

  positionDropdown() {
    computePosition(this.triggerTarget, this.bodyTarget, {
      placement: "bottom-start",
      middleware: [
        offset(8),
        flip(),
        shift({ padding: 8 }),
      ],
    }).then(({ x, y }) => {
      const axisPosition = {
        left: `${x}px`,
        top: `${y}px`
      }

      Object.assign(this.bodyTarget.style, {
        position: "absolute",
        zIndex: 9999,
        ...(this.automaticPositionValue && axisPosition)
      })
    })
  }

  dispatchToggleEvent(opened) {
    const event = new CustomEvent("dropdown:toggle", {
      detail: { opened },
      bubbles: true
    })

    this.element.dispatchEvent(event)
  }

  listenToggleClick() {
    this.triggerTarget.querySelector(':scope > button').addEventListener('click', () => this.toggle())
  }

  listenCloseEvent() {
    document.addEventListener('dropdown:close', () => this.close())
  }
}
