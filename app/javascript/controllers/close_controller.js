import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="close"
export default class extends Controller {
  static targets = ["flash"]
  static values = { timeout: Number }
  static classes = [ "hidden" ]

  connect() {
    console.log("Stimulus message!")
    setTimeout(() => this.hide(), this.timeoutValue)
  }
  hide() {
    console.log("Hide me!")
    this.flashTarget.classList.add(this.hiddenClass)
  }
}
