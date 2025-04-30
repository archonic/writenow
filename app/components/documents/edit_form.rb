# frozen_string_literal: true

module Documents
  class EditForm < RubyUI::Base
    include Phlex::Rails::Helpers::TurboFrameTag
    include Phlex::Rails::Helpers::DOMID
    include Phlex::Rails::Helpers::Routes
    include Phlex::Rails::Helpers::HiddenFieldTag
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      turbo_frame_tag(dom_id(model)) do
        # Not sure we need turbo_frame _top here
        # although the slug change redirects so maybe
        RubyUI::Form(
          action: document_path(model),
          method: :patch,
          class: "space-y-2 mb-4",
          data: {
            turbo_frame: "_top",
            controller: "tiptap--editor autosubmit",
            autosubmit_delay_value: 1000
          }
        ) do
          # field(:name)
          # field(:slug)
          hidden_field_tag :token, model.token, data: { tiptap__editor_target: "tokenField" }
          div(class: "flex flex-col") do
            Tiptap::Toolbar()
            div(class: "border-1 border-gray-300 border-t-0 rounded-b-md", data: { tiptap__editor_target: "tiptap" })
          end
        end
      end
    end

    # private

    # def field(attribute)
    #   FormField do
    #     FormFieldLabel { attribute.to_s.humanize }
    #     invalid_class = model.errors[attribute].any? ? "border-red-500" : ""
    #     Input(
    #       name: "document[#{attribute}]",
    #       placeholder: attribute.to_s.humanize,
    #       required: true,
    #       autofill: false,
    #       class: invalid_class,
    #       value: model.send(attribute),
    #       data: {
    #         action: "input->autosubmit#submit"
    #       }
    #     )
    #     if model.errors[attribute].any?
    #       model.errors[attribute].each do |error|
    #         FormFieldError { error }
    #       end
    #     end
    #   end
    # end
  end
end
