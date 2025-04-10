import { Controller } from "@hotwired/stimulus"
import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'

export default class extends Controller {
  connect() {
    new Editor({
      element: document.querySelector('.element'),
      extensions: [StarterKit],
      autofocus: true,
      editable: true,
      injectCSS: false,
      content: '<p>Hello World!</p>',
    })
  }
}
