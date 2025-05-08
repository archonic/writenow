# frozen_string_literal: true

module Documents
  class NewForm < RubyUI::Base
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::DOMID
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      turbo_frame_tag(dom_id(model), class: "py-4") do
        RubyUI::Form(action: "/docs", method: :post, data: { turbo_frame: "_top" }) do
          name_field
        end
      end
    end

    private

    def name_field
      FormField do
        invalid_class = model.errors[:name].any? ? "border-red-500" : ""
        Input(
          name: "document[name]",
          placeholder: "Name",
          required: true,
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
