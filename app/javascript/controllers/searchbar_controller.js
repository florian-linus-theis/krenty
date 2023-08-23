import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="searchbar"
export default class extends Controller {
  static targets = ["togglableElement", "originalLink"]

  connect() {
  }

  toggle() {
    this.originalLinkTarget.classList.add("d-none");
    this.togglableElementTarget.classList.remove("d-none");
  }
}
