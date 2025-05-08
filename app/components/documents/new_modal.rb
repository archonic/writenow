# frozen_string_literal: true

module Documents
  class NewModal < Components::Base
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      DialogWrapper do
        DialogTrigger do
          i(class: "ri-add-line")
          plain "New"
        end
        DialogModal do
          DialogTitle do
            i(class: "ri-draft-line")
            plain "Create a new document"
          end
          Documents::NewForm(model:)
          DialogFooter do
            RubyUI::Button(variant: :outline, data: { action: "app--dialog#close" }) { "Cancel" }
            RubyUI::Button(type: "submit", value: "Submit", form: dom_id(model)) { "Create" }
          end
          DialogClose()
        end
      end
    end
  end
end
