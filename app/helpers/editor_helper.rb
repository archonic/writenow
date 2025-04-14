module EditorHelper
  # key: ["command", "active key", "icon"]
  TOGGLE_BUTTON_LOOKUP = {
    heading: [ "toggleHeading", "heading",  "ri-heading" ],     # do it
    bold: [  "toggleBold", "bold", "ri-bold" ],
    italic: [ "toggleItalic", "italic", "ri-italic" ],
    strike: [ "toggleStrike", "strike", "ri-strikethrough" ],
    blockquote: [ "toggleBlockquote", "blockquote", "ri-quote-text" ],
    codeblock: [ "toggleCodeblock", "codeblock", "ri-code-box-line" ],  # install and use code block lowlight (syntax highlighting)
    ul: [ "toggleBulletList", "bulletList", "ri-list-unordered" ],
    ol: [ "toggleOrderedList", "orderedList", "ri-list-ordered-2" ],
    attach: [ "cmdattach", "attach", "cmdAttach", "ri-attachment-2" ],              # do it
    undo: [ "undo", "undo", "ri-arrow-go-back-line" ],
    redo: [ "redo", "redo", "ri-arrow-go-forward-line" ]
  }.freeze

  SET_UNSET_BUTTON_LOOKUP = {
    link: {
      set: [ "editor#setLink", "link", "ri-link" ],
      unset: [ "editor#unsetLink", "link", "ri-link-unlink-m" ]
    }
  }

  def toggle_button(key)
    render Editor::Button.new(
        data_action: "editor#runCommand",
        data_command: TOGGLE_BUTTON_LOOKUP[key].try(:first),
        data_active: TOGGLE_BUTTON_LOOKUP[key].try(:second)
      ) do
        tag.i(class: TOGGLE_BUTTON_LOOKUP[key].try(:last))
    end
  end

  def set_unset_button(key)
    set = render Editor::Button.new(
        data_action: SET_UNSET_BUTTON_LOOKUP[key][:set].try(:first),
        data_active: SET_UNSET_BUTTON_LOOKUP[key][:set].try(:second)
      ) do
        tag.i(class: SET_UNSET_BUTTON_LOOKUP[key][:set].try(:last))
    end
    unset = render Editor::Button.new(
        data_action: SET_UNSET_BUTTON_LOOKUP[key][:unset].try(:first),
        data_active: SET_UNSET_BUTTON_LOOKUP[key][:unset].try(:second)
      ) do
        tag.i(class: SET_UNSET_BUTTON_LOOKUP[key][:unset].try(:last))
    end
    set + unset
  end
end
