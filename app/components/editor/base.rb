# frozen_string_literal: true

class Editor::Base < RubyUI::Base
  def initialize(key = nil, **attrs)
    if key
      @key = key.to_sym
      attrs.merge!(data: data_attrs)
    end

    super(**attrs)
  end

  private

  def data_attrs
    case @key
    when :paragraph
      {
        action: "ruby-ui--dropdown-menu#close editor#runCommand",
        command: "setParagraph",
        active: "paragraph"
      }
    when :heading_1
      {
        action: "ruby-ui--dropdown-menu#close editor#toggleHeading",
        level: 1,
        active: "heading"
      }
    when :heading_2
      {
        action: "ruby-ui--dropdown-menu#close editor#toggleHeading",
        level: 2,
        active: "heading"
      }
    when :heading_3
      {
        action: "ruby-ui--dropdown-menu#close editor#toggleHeading",
        level: 3,
        active: "heading"
      }
    when :heading_4
      {
        action: "ruby-ui--dropdown-menu#close editor#toggleHeading",
        level: 4,
        active: "heading"
      }
    when :heading_5
      {
        action: "ruby-ui--dropdown-menu#close editor#toggleHeading",
        level: 5,
        active: "heading"
      }
    when :heading_6
      {
        action: "ruby-ui--dropdown-menu#close editor#toggleHeading",
        level: 6,
        active: "heading"
      }
    when :ul
      {
        action: "ruby-ui--dropdown-menu#close editor#runCommand",
        command: "toggleBulletList",
        active: "bulletList"
      }
    when :ol
      {
        action: "ruby-ui--dropdown-menu#close editor#runCommand",
        command: "toggleOrderedList",
        active: "orderedList"
      }
    when :codeblock
      {
        action: "editor#runCommand",
        command: "toggleCodeBlock",
        active: "codeBlock"
      }
    when :bold
      {
        action: "editor#runCommand",
        command: "toggleBold",
        active: "bold"
      }
    when :italic
      {
        action: "editor#runCommand",
        command: "toggleItalic",
        active: "italic"
      }
    when :strike
      {
        action: "editor#runCommand",
        command: "toggleStrike",
        active: "strike"
      }
    when :blockquote
      {
        action: "editor#runCommand",
        command: "toggleBlockquote",
        active: "blockquote"
      }
    when :attach
      {
        action: "cmdAttach",
        active: "attach"
      }
    when :undo
      {
        action: "editor#runCommand",
        command: "undo",
        active: "undo",
        disable: "undo"
      }
    when :redo
      {
        action: "editor#runCommand",
        command: "redo",
        active: "redo",
        disable: "redo"
      }
    when :link_set
      {
        action: "editor#setLink",
        hidden: "link"
      }
    when :link_unset
      {
        action: "editor#unsetLink",
        visible: "link"
      }
    else
      raise ArgumentError.new("Key passed to #{self.Class.name} is not recognized: #{key}")
    end
  end
end
