import { Editor } from '@tiptap/core'
import Document from '@tiptap/extension-document'
import CodeBlockLowlight from '@tiptap/extension-code-block-lowlight'
import StarterKit from '@tiptap/starter-kit'
import Link from '@tiptap/extension-link'
import Placeholder from '@tiptap/extension-placeholder'

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

export default class TiptapSetup {
  editor: Editor
  buttonTargets: HTMLButtonElement[]
  blockSelectorTarget: HTMLButtonElement
  tokenFieldTarget: HTMLInputElement
  initialContentTarget: HTMLTemplateElement
  tiptapTarget: HTMLDivElement

  // @ts-ignore
  collaboration: TiptapCollabProvider
  // @ts-ignore
  doc: Y.Doc

  constructor(
    buttonTargets: HTMLButtonElement[],
    blockSelectorTarget: HTMLButtonElement,
    tokenFieldTarget: HTMLInputElement,
    initialContentTarget: HTMLTemplateElement,
    tiptapTarget: HTMLDivElement
  ) {
    this.buttonTargets = buttonTargets
    this.blockSelectorTarget = blockSelectorTarget
    this.editor = this.initializeEditor(tiptapTarget)
    this.connectToCollaboration(this.doc, this.editor, tokenFieldTarget.value, initialContentTarget.innerHTML)
  }

  editorInstance() {
    return this.editor
  }

  initializeEditor(element: HTMLDivElement) {
    const lowlight = createLowlight(all)
    this.registerLowlightLanguages(lowlight)

    const TitledDocument = Document.extend({
      content: 'heading block*',
    })

    const controller = this
    this.doc = new Y.Doc()

    return new Editor({
      element: element,
      extensions: [
        StarterKit.configure({
          document: false,
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
          document: this.doc,
        }),
        TitledDocument,
        Placeholder.configure({
          placeholder: ({ node }) => {
            if (node.type.name === 'heading') {
              return 'New document'
            }
            // Ensure a string is always returned
            // This is where we can place a `/command` prompt
            return ''
          },
        }),
      ],
      autofocus: true,
      editable: true,
      injectCSS: false,
      onTransaction({ editor }) {
        controller.updateButtonState()
      }
    })
  }

  connectToCollaboration(doc: Y.Doc, editor: Editor, documentName: string, initialContent: string) {
    new TiptapCollabProvider({
      name: documentName,
      baseUrl: 'http://127.0.0.1:1234',
      token: 'notoken',                   // Your user JWT token
      document: doc,
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
}

export { TiptapSetup }
