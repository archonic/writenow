import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    this.editor = this.element.parentElement.editor
    this.setActiveState()
  }

  setActiveState() {
    if (this.editor.isActive('link')) {
      this.classList.add("active")
    } else {
      this.classList.remove("active")
    }
  }
}
