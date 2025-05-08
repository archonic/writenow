# frozen_string_literal: true

module Documents
  class SettingsForm < Components::Base
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      turbo_frame_tag(dom_id(model), class: "py-4") do
        RubyUI::Form(action: "/doc", method: :patch, data: { turbo_frame: "_top" }) do
          slug_field
        end
      end
    end

    private

    def slug_field
      FormField do
        # TODO Perhaps the RubyUI::Input should take a model / attribute and handle errors itself
        invalid_class = model.errors[:slug].any? ? "border-red-500" : ""
        FormFieldLabel { plain "Slug" }
        Input(
          name: "document[slug]",
          placeholder: "Slug",
          required: true,
          value: model.slug,
          class: invalid_class
        )
        if model.errors[:name].any?
          model.errors[:name].each do |error|
            FormFieldError { error }
          end
        end
      end
    end
  end
end
