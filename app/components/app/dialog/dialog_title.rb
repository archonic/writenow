# frozen_string_literal: true

module App
  class DialogTitle < Components::Base
    def view_template(&)
      h3(**attrs, &)
    end

    private

    def default_attrs
      {
        class: "text-lg font-semibold leading-none tracking-tight inline-flex gap-2"
      }
    end
  end
end
