# frozen_string_literal: true

module Editor
  class Button < RubyUI::Base
    # May want `inline-flex` on this but it messes with `hidden`
    DEFAULT_CLASSES = "whitespace-nowrap items-center justify-center rounded-sm
    font-medium transition-colors
    focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring
    disabled:pointer-events-none disabled:opacity-50
    bg-gray-300 text-gray-800
    hover:bg-gray-200
    h-8 w-8
    cursor-pointer"

    def initialize(key = nil, **attrs)
      if key
        @key = key.to_sym
        attrs.merge!(data: data_attrs)
      end

      super(**attrs)
    end

    def view_template(&)
      button(**attrs, &)
    end

    private

    def default_attrs
      {
        type: :button,
        class: DEFAULT_CLASSES,
        data_editor_target: "button"
      }
    end

    def data_attrs
      case @key
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
      when :codeblock
        {
          action: "editor#runCommand",
          command: "toggleCodeblock",
          active: "codeblock"
        }
      when :ul
        {
          action: "editor#runCommand",
          command: "toggleBulletList",
          active: "bulletList"
        }
      when :ol
        {
          action: "editor#runCommand",
          command: "toggleOrderedList",
          active: "orderedList"
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
        raise ArgumentError.new("Key passed to Editor::Button is not recognized: #{key}")
      end
    end
  end
end
