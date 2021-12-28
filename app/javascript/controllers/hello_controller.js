import { Controller } from "@hotwired/stimulus"
import JSONEditor from "jsoneditor"

export default class extends Controller {
  static targets = ["output", "editor"]
  
  initialize() {
    const editorOptions = {
      modes: ['code', 'form', 'text', 'tree', 'view', 'preview'],
    }

    const outputOptions = {
      mode: "preview",
      modes: ['code', 'form', 'text', 'tree', 'view', 'preview'],
    }

    this.editor = new JSONEditor(this.editorTarget, editorOptions)
    this.output = new JSONEditor(this.outputTarget, outputOptions)

    this.json = {
      "Array": [1, 2, 3],
      "Boolean": true,
      "Null": null,
      "Number": 123,
      "Object": { "a": "b", "c": "d" },
      "String": "Hello World"
    }
  }

  connect() {
    this.editor.set(
      {
        "Array": [1, 2, 3],
        "Boolean": true,
        "Null": null,
        "Number": 123,
        "Object": { "a": "b", "c": "d" },
        "String": "Hello World"
      }
    )
  }

  save() {
    //this.outputTarget.textContent =
    // `Hello, ${this.nameTarget.value}!`

    this.output.set(this.editor.get())
  }
}
