import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="global-modal"
export default class extends Controller {
  static targets = ["output"]
  
  connect() {
    console.log("Hello from Modal Controller!");
  }

  close(event) {
    console.log("Close modal");
    this.outputTarget.classList.add("hidden");
  }
}
