import { Controller } from "@hotwired/stimulus"
import { TiptapSetup, Editor } from './tiptap_setup'
import { SingleCommands } from '@tiptap/core'

// Connects to data-controller="tiptap--editor"
export default class extends Controller<HTMLDivElement> {
  static targets = ["button", "blockSelector", "tokenField", "initialContent", "tiptap"]

  declare readonly buttonTargets: HTMLButtonElement[]
  declare readonly blockSelectorTarget: HTMLButtonElement
  declare readonly tokenFieldTarget: HTMLInputElement
  declare readonly initialContentTarget: HTMLTemplateElement
  declare readonly tiptapTarget: HTMLDivElement
  declare editor: Editor

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
  runCommand(event: MouseEvent & { currentTarget: HTMLButtonElement }) {
    // NOTE Might want to get more strict about whitelisting commands
    const command: string = event.currentTarget.dataset.command as keyof SingleCommands
    // @ts-ignore
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

  toggleHeading(event: MouseEvent & { currentTarget: HTMLButtonElement }) {
    let level = parseInt(event.currentTarget.dataset.level || '1')
    this.editor.chain().focus().toggleHeading({ level: level as any }).run()
  }

  unsetLink() {
    this.editor.chain().focus().unsetLink().run()
  }
}
