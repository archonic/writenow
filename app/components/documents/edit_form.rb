# frozen_string_literal: true

module Documents
  class EditForm < RubyUI::Base
    include Phlex::Rails::Helpers::HiddenFieldTag
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      div(data: { controller: "tiptap--editor" }) do
        hidden_field_tag :token, model.token, data: { tiptap__editor_target: "tokenField" }
        div(class: "flex flex-col") do
          Tiptap::Toolbar()
          div(data: { tiptap__editor_target: "tiptap" })
        end
      end
    end
  end
end
