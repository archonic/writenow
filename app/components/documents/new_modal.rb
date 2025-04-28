# frozen_string_literal: true

module Documents
  class NewModal < RubyUI::Base
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
          div(class: "py-4") do
            Form(action: "/docs", method: :post, id: "new_doc_form", data: { action: "submit->ruby-ui--dialog#dismiss" }) do
              FormField do
                Input(name: "document[name]", placeholder: "Name", required: true, data: { ruby_ui__dialog_target: "autofocus" })
              end
            end
          end
          DialogFooter(class: "justify-between") do
            Button(variant: :outline, data: { action: "click->ruby-ui--dialog#dismiss" }) { "Cancel" }
            Button(type: "submit", value: "Submit", form: "new_doc_form") { "Create" }
          end
        end
      end
    end
  end
end
