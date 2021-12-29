import { Controller } from "@hotwired/stimulus"
import JSONEditor from "jsoneditor"

export default class extends Controller {
  static targets = ["input"]
  static values = {
    content: Object
  }

  initialize() {
    const inputOptions = {
      mode: 'preview'
    }

    this.input = new JSONEditor(this.inputTarget, inputOptions)
  }

  connect() {
    this.input.set(this.contentValue)
  }
}
