// app/javascript/controllers/mobile_check_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (this.isMobileDevice()) {
      this.showDesktopMessage();
    }
  }

  isMobileDevice() {
    return /Mobi|Android/i.test(navigator.userAgent);
  }

  showDesktopMessage() {
    const messageDiv = document.createElement('div');
    messageDiv.id = 'desktop-message';
    messageDiv.innerHTML = 'This website is best viewed in desktop mode. Please switch to desktop mode on your mobile device.';
    messageDiv.style.position = 'fixed';
    messageDiv.style.bottom = '10px';
    messageDiv.style.left = '10px';
    messageDiv.style.backgroundColor = 'rgba(0, 0, 0, 0.7)';
    messageDiv.style.color = 'white';
    messageDiv.style.padding = '10px';
    messageDiv.style.zIndex = '1000';
    document.body.appendChild(messageDiv);
  }
}
