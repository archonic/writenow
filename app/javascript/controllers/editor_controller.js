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
        editor.controller.updateButtonState()
      }
    })
    this.editor.controller = this
  }

  disconnect() {
    this.editor.destroy()
  }

  updateButtonState() {
    for (const button of this.buttonTargets) {
      this.setActiveState(button)
      this.setDisabledState(button)
      this.setVisibleState(button)
    }
  }

  setActiveState(button) {
    if (button.dataset.active !== undefined) {
      if (button.dataset.level === undefined) {
        if (this.editor.isActive(button.dataset.active)) {
          button.classList.add("bg-sky-300")
        } else {
          button.classList.remove("bg-sky-300")
        }
      } else {
        let level = parseInt(button.dataset.level)
        if (this.editor.isActive('heading', { level: level })) {
          button.classList.add("bg-sky-300")
        } else {
          button.classList.remove("bg-sky-300")
        }
      }
    }
  }

  setDisabledState(button) {
    if (button.dataset.disable !== undefined) {
      if (this.editor.can()[button.dataset.disable]()) {
        button.removeAttribute("disabled")
      } else {
        button.setAttribute("disabled", "disabled")
      }
    }
  }

  setVisibleState(button) {
    if (button.dataset.visible !== undefined) {
      if (this.editor.isActive(button.dataset.visible)) {
        button.classList.remove("hidden")
      } else {
        button.classList.add("hidden")
      }
    }

    if (button.dataset.hidden !== undefined) {
      if (!this.editor.isActive(button.dataset.hidden)) {
        button.classList.remove("hidden")
      } else {
        button.classList.add("hidden")
      }
    }
  }

  runCommand(event) {
    let command = event.currentTarget.dataset.command
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

  toggleHeading(event) {
    let level = parseInt(event.currentTarget.dataset.level)
    this.editor.chain().focus().toggleHeading({ level: level }).run()
  }

  unsetLink() {
    this.editor.chain().focus().unsetLink().run()
  }
}
