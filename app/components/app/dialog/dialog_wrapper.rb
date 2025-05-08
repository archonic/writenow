# frozen_string_literal: true

module App
  class DialogWrapper < Components::Base
    def initialize(**attrs)
      super(**attrs)
    end

    def view_template(&)
      div(**attrs) do
        yield
      end
    end

    private

    def default_attrs
      {
        data: {
          controller: "app--dialog"
        }
      }
    end
  end
end
