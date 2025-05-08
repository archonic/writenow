# frozen_string_literal: true

module App
  class DialogHeader < Components::Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        class: "text-center sm:text-left rtl:sm:text-right"
      }
    end
  end
end
