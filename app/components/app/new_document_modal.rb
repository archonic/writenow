# frozen_string_literal: true

module App
  class NewDocumentModal < Components::Base
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      DialogWrapper do
        DialogTrigger(class: "gap-2") do
          i(class: "ri-add-line")
          plain "New"
        end
        DialogContent do
          DialogHeader do
            DialogTitle(class: "inline-flex gap-2") do
              i(class: "ri-draft-line")
              plain "Create a new document"
            end
            Documents::NewForm(model:)
            DialogFooter(class: "justify-between") do
              Button(variant: :outline, data: { action: "app--dialog#close" }) { "Cancel" }
              Button(type: "submit", value: "Submit", form: "new_doc_form") { "Create" }
            end
          end
        end
      end
    end
  end
end
