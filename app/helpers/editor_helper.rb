module EditorHelper
  # key: ["action", "icon"]
  TOGGLE_BUTTON_LOOKUP = {
    heading: [ "editor#heading", "ri-heading" ],
    bold: [  "editor#bold", "ri-bold" ],
    italic: [ "editor#italic", "ri-italic" ],
    strike: [ "editor#strike", "ri-strikethrough" ],
    blockquote: [ "editor#blockquote", "ri-quote-text" ],
    codeblock: [ "editor#codeblock", "ri-code-box-line" ],
    ul: [ "editor#ul", "ri-list-unordered" ],
    ol: [ "editor#ol", "ri-list-ordered-2" ],
    outdent: [ "editor#outdent", "ri-indent-decrease" ],
    indent: [ "editor#indent", "ri-indent-increase" ],
    attach: [ "editor#attach", "ri-attachment-2" ],
    undo: [ "editor#undo", "ri-arrow-go-back-line" ],
    redo: [ "editor#redo", "ri-arrow-go-forward-line" ]
  }.freeze

  SET_UNSET_BUTTON_LOOKUP = {
    link: {
      set: [ "editor#setLink", "ri-link" ],
      unset: [ "editor#unsetLink", "ri-link-unlink-m" ]
    }
  }


  def toolbar_button(key)
    render Editor::Button.new(data_action: TOGGLE_BUTTON_LOOKUP[key].try(:first)) do
      tag.i(class: TOGGLE_BUTTON_LOOKUP[key].try(:last))
    end
  end

  def set_unset_button(key)
    set = render Editor::Button.new(data_action: SET_UNSET_BUTTON_LOOKUP[key][:set].try(:first)) do
      tag.i(class: SET_UNSET_BUTTON_LOOKUP[key][:set].try(:last))
    end
    unset = render Editor::Button.new(data_action: SET_UNSET_BUTTON_LOOKUP[key][:unset].try(:first)) do
      tag.i(class: SET_UNSET_BUTTON_LOOKUP[key][:unset].try(:last))
    end
    set + unset
  end
end
