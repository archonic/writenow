# frozen_string_literal: true

module Editor
  class DropdownMenuItem < RubyUI::Base
    DEFAULT_CLASSES = "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors
      hover:bg-accent hover:text-accent-foreground
      focus:bg-accent focus:text-accent-foreground
      aria-selected:bg-accent aria-selected:text-accent-foreground
      data-[disabled]:pointer-events-none data-[disabled]:opacity-50"

    def initialize(key = nil, **attrs)
      if key
        @key = key.to_sym
        attrs.merge!(data: data_attrs)
      end

      super(**attrs)
    end

    def view_template(&)
      a(**attrs, &)
    end

    private

    def default_attrs
      {
        role: "menuitem",
        class: DEFAULT_CLASSES,
        tabindex: "-1",
        data_orientation: "vertical",
        data_ruby_ui__dropdown_menu_target: "menuItem",
        data_editor_target: "button"
      }
    end

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
      else
        raise ArgumentError.new("Key passed to Editor::Button is not recognized: #{key}")
      end
    end
  end
end
