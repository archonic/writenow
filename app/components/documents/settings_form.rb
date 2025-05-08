# frozen_string_literal: true

module Documents
  class SettingsForm < Components::Base
    include Phlex::Rails::Helpers::FormWith
    attr_reader :model, :params

    def initialize(model:, params: {}, **attrs)
      @model = model
      @params = params
      super(**attrs)
    end

    def view_template(&)
      turbo_frame_tag(dom_id(model)) do
        RubyUI::Form(
          action: document_path(model),
          method: :patch,
          data: { controller: "autosubmit" }
        ) do
          form_errors
          slug_field
        end
      end
    end

    private

    def form_errors
      if model.errors.any?
        Alert(variant: :warning) do
          i(class: "ri-error-warning-line size-5")
          AlertTitle { "Errors" }
          AlertDescription do
            model.errors.full_messages.each do |error|
              ul do
                li { plain error }
              end
            end
          end
        end
      end
    end

    def slug_field
      FormField do
        invalid_class = model.errors[:slug].any? ? "border-red-500" : ""
        FormFieldLabel { plain "Slug" }
        Input(
          name: "document[slug]",
          placeholder: "your-slug-here",
          autocomplete: "off",
          required: true,
          value: params.dig(:document, :slug) || model.slug,
          class: invalid_class,
          data: { action: "autosubmit#submit" }
        )
        # Displays HTML5 validation errors via ruby-ui--form-field-controller
        FormFieldError()
      end
    end
  end
end
