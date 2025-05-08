# frozen_string_literal: true

module App
  class DialogTrigger < Components::Base
    def view_template(&)
      RubyUI::Button(**attrs) do
        yield
      end
    end

    private

    def default_attrs
      {
        data: {
          action: "app--dialog#open"
        },
        class: "gap-2"
      }
    end
  end
end
