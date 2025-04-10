import { Controller } from "@hotwired/stimulus"
import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'

export default class extends Controller {
  static targets = ["button", "initialContent"]

  connect() {
    this.editor = new Editor({
      element: document.querySelector('.element'),
      extensions: [
        StarterKit,
        Link.configure({
          openOnClick: false,
          defaultProtocol: 'https',
        })
      ],
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
    console.log("setLink")
    const previousUrl = this.editor.getAttributes('link').href
    const url = window.prompt('URL', previousUrl)

    // cancelled
    if (url === null) {
      return
    }

    // empty
    if (url === '') {
      this.editor
        .chain()
        .focus()
        .extendMarkRange('link')
        .unsetLink()
        .run()

      return
    }

    // update link
    this.editor
      .chain()
      .focus()
      .extendMarkRange('link')
      .setLink({ href: url })
      .run()
  }

  unsetLink() {
    console.log("unsetLink")
    this.editor.chain().focus().unsetLink().run()
  }
}
