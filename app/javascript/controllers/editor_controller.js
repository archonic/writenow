import { Controller } from "@hotwired/stimulus"
import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'

export default class extends Controller {
  static targets = ["button", "initialContent"]

  connect() {
    this.editor = new Editor({
      element: document.querySelector('.element'),
      extensions: [StarterKit],
      autofocus: true,
      editable: true,
      injectCSS: false,
      content: this.initialContentTarget.innerHTML,
    })
    this.element.editor = this.editor
  }

  // Could potentially pass a data attribute to exec? If we whitelist?
  bold() {
    this.editor.chain().focus().toggleBold().run()
  }

  italic() {
    this.editor.chain().focus().toggleItalic().run()
  }

  strike() {
    this.editor.chain().focus().toggleStrike().run()
  }

  setLink() {
    this.editor.chain().focus().setLink().run()
  }

  unsetLink() {
    this.editor.chain().focus().unsetLink().run()
  }
}
