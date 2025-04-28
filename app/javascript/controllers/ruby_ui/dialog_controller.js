import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ruby-ui--dialog"
export default class extends Controller {
  static targets = ["content", "autofocus"]
  static values = {
    open: {
      type: Boolean,
      default: false
    },
  }

  connect() {
    if (this.openValue) {
      this.open()
    }
  }

  open(e) {
    e.preventDefault() // what event are we preventing?
    document.body.insertAdjacentHTML('beforeend', this.contentTarget.innerHTML)
    // prevent scroll on body
    document.body.classList.add('overflow-hidden')
  }

  dismiss() {
    // allow scroll on body
    document.body.classList.remove('overflow-hidden')
    this.element.remove()
  }

  autofocusTargetConnected() {
    this.autofocusTarget.focus()
  }

  autofocusTargetDisconnected() {
    this.autofocusTarget.blur()
  }
}
