# frozen_string_literal: true

module Editor
  class Button < Editor::Base
    # May want `inline-flex` on this but it messes with `hidden`
    DEFAULT_CLASSES = "whitespace-nowrap items-center justify-center rounded-sm
    font-medium transition-colors
    focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring
    disabled:pointer-events-none disabled:opacity-50
    bg-gray-300 text-gray-800
    hover:bg-gray-200
    h-8 w-8
    cursor-pointer"

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
