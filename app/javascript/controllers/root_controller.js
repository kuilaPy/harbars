import { Controller } from "@hotwired/stimulus"
import { v4 as uuid_v4 } from 'uuid';

export default class extends Controller {
  static targets = ["user", "link"]
  connect() {
    console.log("connected root")
    this.ensureExternalUserId()
  }
  ensureExternalUserId() {
    let externalUserId
    if(this.hasUserTarget){
      console.log(this.userTarget.dataset)
      externalUserId = this.userTarget.dataset.externalId
      if(externalUserId != undefined) {
        localStorage.setItem("externalUserId", externalUserId)
      }
    }else{
      externalUserId = localStorage.getItem("externalUserId")
      if (!externalUserId) {
        externalUserId = uuid_v4()
        localStorage.setItem("externalUserId", externalUserId)
      }
    }
    if(this.hasLinkTarget){
      this.updateHref(externalUserId)
    }

  }

  updateHref(externalUserId) {
    this.linkTargets.forEach(link => {
      console.log({link})
      const url = new URL(link.href);
      console.log({url})
      url.searchParams.set('external_id', externalUserId); // Add or update query parameter
      link.href = url.toString();
    });
  }
  
}
