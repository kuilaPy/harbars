import { Controller } from "@hotwired/stimulus"
import { v4 as uuid_v4 } from 'uuid';
export default class extends Controller {
  static targets = ["count", "toast"]

  connect() {
    this.updateCartCount()
    this.ensureExternalUserId()
    console.log($('#flash'))
  }

  ensureExternalUserId() {
    let externalUserId = localStorage.getItem("externalUserId")
    if (!externalUserId) {
      externalUserId = uuid_v4()
      localStorage.setItem("externalUserId", externalUserId)
    }
    this.externalUserId = externalUserId
  }

  addToCart(event) {
    const productId = event.currentTarget.dataset.productId
    let cart = JSON.parse(localStorage.getItem("cart")) || []

    const item = cart.find(item => item.product_id === productId)
    if (item) {
      item.quantity += 1
    } else {
      cart.push({ product_id: productId, quantity: 1 })
    }
    this.sendAddToCartRequest(productId, cart)
  }

  sendAddToCartRequest(productId, cart) {
    let externalUserId = this.externalUserId
    $.ajax({
      url: '/carts',
      type: 'POST',
      headers: {
        'Accept': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      data: {cart: {
          external_user_id: externalUserId,
          product_id: productId
        }
      }
    }).done((res) => {
      //console.log("from done", res.status)
      // console.log("from done:----", res.message)
      localStorage.setItem("cart", JSON.stringify(cart))
      this.type = "success"
      this.message = "Item added to cart successfully"
      this.showToast()
      this.updateCartCount()
    }).fail((e) => {
      console.log("Error", e)
      this.type = "error"
      this.message = e?.responseJSON?.message ?? "Something went wrong"
      this.showToast()
    })
  }

  updateCartCount() {
    let cart = JSON.parse(localStorage.getItem("cart")) || []
    const count = cart.reduce((total, item) => total + item.quantity, 0)
    this.countTarget.innerText = count
  }

  showToast() {
    let el = document.getElementById('flash')
    const controller = this.application.getControllerForElementAndIdentifier(el, 'toast')
    controller.showToast(this.message, this.type)
  }
}