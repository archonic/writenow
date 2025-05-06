import { Controller } from "@hotwired/stimulus"
import { TiptapSetup } from './tiptap_setup'

// Connects to data-controller="tiptap--editor"
export default class extends Controller {
  static targets = ["button", "blockSelector", "tokenField", "initialContent", "tiptap"]

  connect() {
    this.editor = new TiptapSetup(
      this.buttonTargets,
      this.blockSelectorTarget,
      this.tokenFieldTarget,
      this.initialContentTarget,
      this.tiptapTarget,
    ).editorInstance()
  }

  disconnect() {
    this.editor.destroy()
  }

  // Can be used for any simple toggle commands (bold, italic, etc)
  runCommand(event) {
    let command = event.currentTarget.dataset.command
    this.editor.chain().focus()[command]().run()
  }

  setLink() {
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
