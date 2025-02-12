import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="close"
export default class extends Controller {
  static targets = ["flash"]
  static values = { timeout: Number }
  static classes = [ "hidden" ]

  connect() {
    setTimeout(() => this.hide(), this.timeoutValue)
  }
  hide() {
    this.flashTarget.classList.add(this.hiddenClass)
  }
}
