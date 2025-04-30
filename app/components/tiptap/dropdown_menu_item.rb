# frozen_string_literal: true

module Tiptap
  class DropdownMenuItem < Tiptap::Base
    DEFAULT_CLASSES = "relative flex cursor-pointer select-none items-center rounded-sm px-2 py-1.5 text-sm outline-none transition-colors
      hover:bg-accent hover:text-accent-foreground
      focus:bg-accent focus:text-accent-foreground
      aria-selected:bg-accent aria-selected:text-accent-foreground
      data-[disabled]:pointer-events-none data-[disabled]:opacity-50"

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
        data_tiptap__editor_target: "button"
      }
    end
  end
end
