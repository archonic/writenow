import { Controller } from "@hotwired/stimulus"
import { debounce } from "./utils"

// connects to data-controller="autosubmit"
export default class AutoSubmit extends Controller<HTMLFormElement> {
  declare delayValue: number

  static values = {
    delay: {
      type: Number,
      default: 1000,
    },
  }

  initialize(): void {
    this.submit = this.submit.bind(this)
  }

  connect(): void {
    if (this.delayValue > 0) {
      this.submit = debounce(this.submit, this.delayValue)
    }
  }

  submit(): void {
    this.element.requestSubmit()
  }
}
