# frozen_string_literal: true

module App
  class DialogDrawer < Components::Base
    PLACEMENTS = %i[ left right ].freeze
    DEFAULT_CLASSES = %w[
      app-dialog p-6 overflow-y-auto shadow-xl bg-background
      fixed
      min-h-screen h-full w-80
      space-y-4
    ].freeze

    def initialize(placement: :right, **attrs)
      raise ArgumentError unless placement.in? PLACEMENTS
      @placement = placement
      super(**attrs)
    end

    def view_template(&)
      dialog(**attrs) do
        yield
      end
    end

    private

    def default_attrs
      {
        data: {
          app__dialog_target: "dialog"
        },
        class: DEFAULT_CLASSES + [ placement_classes ]
      }
    end

    def placement_classes
      case @placement
      when :left
        "border-r"
      when :right
        # why doesn't right-0 work?
        "left-full translate-x-[-100%] border-l"
      end
    end
  end
end
