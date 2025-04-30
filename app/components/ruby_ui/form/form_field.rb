# frozen_string_literal: true

module RubyUI
  class FormField < Base
    def view_template(&)
      div(**attrs, &)
    end

    private

    def default_attrs
      {
        data: {
          controller: "ruby-ui--form-field"
        }
      }
    end
  end
end
