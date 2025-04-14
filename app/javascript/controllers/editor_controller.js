import { Controller } from "@hotwired/stimulus"
import { Editor } from '@tiptap/core'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'

// NOTE This controller expects to be on the form element
export default class extends Controller {
  static targets = ["button", "initialContent", "tiptap", "bodyInput"]

  connect() {
    this.editor = new Editor({
      element: this.tiptapTarget,
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
      onTransaction({ editor }) {
        editor.controller.checkActive()
      }
    })
    this.editor.controller = this
  }

  disconnect() {
    this.editor.destroy()
  }

  checkActive() {
    for (const button of this.buttonTargets) {
      if (this.editor.isActive(button.dataset.active)) {
        button.classList.add("bg-sky-300")
      } else {
        button.classList.remove("bg-sky-300")
      }
    }
  }

  runCommand(event) {
    let command = event.currentTarget.dataset.command
    console.log("Running command: " + command)
    this.editor.chain().focus()[command]().run()
  }

  submit() {
    this.bodyInputTarget.value = this.editor.getHTML()
    this.element.submit()
  }

  setLink() {
    console.log("setLink")
    const previousUrl = this.editor.getAttributes('link').href
    const url = window.prompt('URL', previousUrl)

    // cancelled
    if (url === null) { return }

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
    this.editor.chain().focus().unsetLink().run()
  }
}
