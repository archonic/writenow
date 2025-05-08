# frozen_string_literal: true

module App
  class DialogWrapper < Components::Base
    def initialize(open: false, **attrs)
      @open = open
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
          controller: "app--dialog",
          app__dialog_open_value: @open
        }
      }
    end
  end
end
