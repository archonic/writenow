# frozen_string_literal: true

module Documents
  class SettingsDrawer < Components::Base
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      DialogWrapper do
        DialogTrigger(variant: :secondary, icon: true) do
          i(class: "ri-settings-3-line")
        end
        DialogDrawer do
          div(class: "flex flex-col space-y-4 h-full") do
            DialogTitle(class: "h-8 border-b border-gray-300") do
              i(class: "ri-settings-3-line")
              plain "Document settings"
            end
            div(class: "grow") do
              SettingsForm(model:, class: "h-full")
            end
            DialogFooter do
              RubyUI::Button(variant: :destructive, class: "w-full") do
                i(class: "ri-delete-bin-line")
                plain "Delete"
              end
            end
            DialogClose()
          end
        end
      end
    end
  end
end
