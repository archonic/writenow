# frozen_string_literal: true

module App
  class DialogModal < Components::Base
    DEFAULT_CLASSES = %w[
      app-dialog p-6 overflow-y-auto shadow-xl bg-background
      absolute left-[50%] top-[50%] translate-x-[-50%] translate-y-[-50%]
      w-full max-h-screen md:w-full max-w-lg
      border
      rounded-lg sm:rounded-lg
    ].freeze

    def view_template(&)
      dialog(**attrs) do
        div(class: "flex flex-col space-y-2") do
          yield
        end
      end
    end

    private

    def default_attrs
      {
        data: {
          app__dialog_target: "dialog"
        },
        class: DEFAULT_CLASSES
      }
    end
  end
end
