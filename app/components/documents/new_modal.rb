# frozen_string_literal: true

module Documents
  class NewModal < RubyUI::Base
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      Dialog do
        Button(class: "gap-2", data: { action: "ruby-ui--dialog#open" }) do
          i(class: "ri-add-line")
          div { "New" }
        end
        DialogContent do
          DialogHeader do
            DialogTitle(class: "inline-flex gap-2") do
              i(class: "ri-draft-line")
              div { "Create a new document" }
            end
          end
          Documents::NewForm(model:)
          DialogFooter(class: "justify-between") do
            Button(variant: :outline, data: { action: "click->ruby-ui--dialog#dismiss" }) { "Cancel" }
            Button(type: "submit", value: "Submit", form: "new_doc_form") { "Create" }
          end
        end
      end
    end
  end
end
