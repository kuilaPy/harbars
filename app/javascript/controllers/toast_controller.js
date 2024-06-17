import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['toast', 'message', 'container']
  

  showToast(message, type) {
    this.messageTarget.innerText = message
    let background = type === 'success' ? 'bg-green-100' : type === 'error' ? 'bg-rose-100' : 'bg-blue-100'
    let border = type === 'success' ? 'border-green-500' : type === 'error' ? 'border-red-500' : 'border-blue-500'
    this.containerTarget.classList.add(background, border)
    this.toastTarget.classList.remove('hidden')
    setTimeout(() => {
      this.toastTarget.classList.add('hidden')
      this.containerTarget.classList.remove(background, border)
    }, 3000)
  }
}