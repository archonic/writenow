import { Controller } from "@hotwired/stimulus"
import { Editor } from '@tiptap/core'
import CodeBlockLowlight from '@tiptap/extension-code-block-lowlight'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'

// Code block with syntax highlighting
import css from 'highlight.js/lib/languages/css'
import js from 'highlight.js/lib/languages/javascript'
import ts from 'highlight.js/lib/languages/typescript'
import html from 'highlight.js/lib/languages/xml'
import ruby from 'highlight.js/lib/languages/ruby'
import python from 'highlight.js/lib/languages/python'
import { all, createLowlight } from 'lowlight'

// Collaborative editing
import Collaboration from '@tiptap/extension-collaboration'
import * as Y from 'yjs'
import { TiptapCollabProvider } from '@hocuspocus/provider'

// NOTE This controller expects to be on the form element
export default class extends Controller {
  static targets = ["button", "blockSelector", "initialContent", "tiptap", "bodyInput"]

  connect() {
    const lowlight = createLowlight(all)
    this.registerLowlightLanguages(lowlight)
    const doc = new Y.Doc()

    this.editor = new Editor({
      element: this.tiptapTarget,
      extensions: [
        StarterKit.configure({
          codeBlock: false,
          history: false
        }),
        Link.configure({
          openOnClick: false,
          defaultProtocol: 'https',
        }),
        CodeBlockLowlight.configure({
          lowlight,
        }),
        Collaboration.configure({
          document: doc,
        }),
      ],
      autofocus: true,
      editable: true,
      injectCSS: false,
      // content: this.initialContentTarget.innerHTML,
      onTransaction({ editor }) {
        editor.controller.updateButtonState()
      }
    })
    this.connectToCollaboration(doc, this.editor, this.initialContentTarget.innerHTML)

    this.editor.controller = this
  }

  // Connect to your Collaboration server
  connectToCollaboration(doc, editor, initialContent) {
    const provider = new TiptapCollabProvider({
      name: 'uniquedoc5',              // Unique document identifier for syncing. This is your document name.
      baseUrl: 'http://127.0.0.1:1234',   // Your Cloud Dashboard AppID or `baseURL` for on-premises
      token: 'notoken',                   // Your JWT token
      document: doc,
      // The onSynced callback ensures initial content is set only once using editor.setContent()
      // preventing repetitive content loading on editor syncs.
      onSynced() {
        if (!doc.getMap('config').get('initialContentLoaded') && editor) {
          doc.getMap('config').set('initialContentLoaded', true)
          editor.commands.setContent(initialContent)
        }
      },
    })
  }

  registerLowlightLanguages(lowlight) {
    lowlight.register('html', html)
    lowlight.register('css', css)
    lowlight.register('js', js)
    lowlight.register('ts', ts)
    lowlight.register('ruby', ruby)
    lowlight.register('python', python)
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
    this.setSelection(this.blockSelectorTarget)
  }

  setActiveState(button) {
    const activeClass = "bg-sky-300"
    if (button.dataset.active !== undefined) {
      if (button.dataset.level === undefined) {
        if (this.editor.isActive(button.dataset.active)) {
          button.classList.add(activeClass)
        } else {
          button.classList.remove(activeClass)
        }
      } else {
        let level = parseInt(button.dataset.level)
        if (this.editor.isActive('heading', { level: level })) {
          button.classList.add(activeClass)
        } else {
          button.classList.remove(activeClass)
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

  setSelection(container) {
    container.innerHTML = `<i class="${this.activeIcon()}"></i>`
  }

  // Potential for refactoring. Iterate over buttons with specific data attr?
  // Lowest priority should be last. You can have a paragraph inside other blocks.
  activeIcon() {
    if (this.editor.isActive("heading")) {
      if (this.editor.isActive("heading", { level: 1 })) {
        return "ri-h-1"
      } else if (this.editor.isActive("heading", { level: 2 })) {
        return "ri-h-2"
      } else if (this.editor.isActive("heading", { level: 3 })) {
        return "ri-h-3"
      } else if (this.editor.isActive("heading", { level: 4 })) {
        return "ri-h-4"
      }
    } else if (this.editor.isActive("bulletList")) {
      return "ri-list-unordered"
    } else if (this.editor.isActive("orderedList")) {
      return "ri-list-ordered-2"
    } else if (this.editor.isActive("blockquote")) {
      return "ri-quote-text"
    } else if (this.editor.isActive("codeBlock")) {
      return "ri-code-box-line"
    } else if (this.editor.isActive("paragraph")) {
      return "ri-paragraph"
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
