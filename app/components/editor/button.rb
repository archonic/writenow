# frozen_string_literal: true

module Editor
  class Button < RubyUI::Base
    DEFAULT_CLASSES = "whitespace-nowrap inline-flex items-center justify-center rounded-sm
    font-medium transition-colors
    focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring
    disabled:pointer-events-none disabled:opacity-50
    bg-secondary text-secondary-foreground
    hover:bg-opacity-80
    h-8 w-8
    cursor-pointer"

    def initialize(**attrs)
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
  end
end
