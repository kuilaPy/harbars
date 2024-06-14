import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["count"]

  connect() {
    this.updateCartCount()
  }

  addToCart(event) {
    event.preventDefault()
    const productId = event.currentTarget.dataset.productId
    let cart = JSON.parse(localStorage.getItem("cart")) || []

    if (!cart.includes(productId)) {
      cart.push(productId)
      localStorage.setItem("cart", JSON.stringify(cart))
    }

    this.updateCartCount()
  }

  updateCartCount() {
    let cart = JSON.parse(localStorage.getItem("cart")) || []
    this.countTarget.innerText = cart.length
    
  }
}