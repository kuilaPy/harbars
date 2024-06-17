import { Controller } from "@hotwired/stimulus"
import { v4 as uuid_v4 } from 'uuid';

export default class extends Controller {
  static targets = ["user"]
  connect() {
    this.ensureExternalUserId()
  }
  ensureExternalUserId() {
    if(this.hasUserTarget){
      let externalUserId = this.userTarget.dataset.ExternalId
      localStorage.setItem("externalUserId", externalUserId)
    }else{
      let externalUserId = localStorage.getItem("externalUserId")
      if (!externalUserId) {
        externalUserId = uuid_v4()
        localStorage.setItem("externalUserId", externalUserId)
      }
    }
  }
  
}
