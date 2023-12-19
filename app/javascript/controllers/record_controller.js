import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="record"
export default class extends Controller {

  //static targets = ["value"]

  connect() {
    console.log('yeah', this.element)
  }
}
