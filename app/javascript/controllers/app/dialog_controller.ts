import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="app--dialog"
export default class extends Controller<HTMLDialogElement> {
  static targets = ["dialog"]
  static values = {
    open: {
      type: Boolean,
      default: false
    },
  }
  declare dialogTarget: HTMLDialogElement
  declare openValue: boolean

  connect() {
    if (this.openValue) {
      this.open()
    }
  }

  open() {
    this.dialogTarget.showModal()
  }

  close() {
    this.dialogTarget.close()
  }
}
