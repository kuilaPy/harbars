import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["filterinput"];

  connect() {
    this.filterinputTargets.forEach(input => {
      input.addEventListener("change", this.submitForm.bind(this));
    });
  }

  submitForm() {
    this.element.requestSubmit();
  }
}