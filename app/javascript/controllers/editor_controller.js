import { Controller } from "@hotwired/stimulus"
import JSONEditor from "jsoneditor"

export default class extends Controller {
  static targets = ["input", "output"]
  
  initialize() {
    const inputOptions = {
      modes: ['code', 'form', 'text', 'tree', 'view', 'preview'],
    }

    this.input = new JSONEditor(this.inputTarget, inputOptions)
  }

  connect() {
    // Load the value from the content field and set the editor to that
    const json = JSON.parse(this.outputTarget.value) 
    this.input.set(json)
  }

  save() {
    this.outputTarget.value = JSON.stringify(this.input.get())
  }
}
