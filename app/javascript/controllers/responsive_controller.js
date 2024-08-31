import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="responsive"
export default class extends Controller {
  static targets = ["mobile", "web"]
  
  connect() {
    this.checkScreenWidth()
    window.addEventListener("resize", this.checkScreenWidth.bind(this))
  }

  disconnect() {
    window.removeEventListener("resize", this.checkScreenWidth.bind(this))
  }

  checkScreenWidth() {
    const screenWidth = window.innerWidth
    const breakpoint = 1024 // Tailwind's "lg" breakpoint in pixels

    if (screenWidth < breakpoint) {
      // Remove the web element for mobile view
      this.webTarget.remove()
    } else {
      // Remove the mobile element for web view
      this.mobileTarget.remove()
    }
  }
}
