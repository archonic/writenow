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
          DialogHeader(class: "h-8 border-b border-gray-300") do
            DialogTitle do
              i(class: "ri-settings-3-line")
                plain "Document settings"
            end
          end
          SettingsForm(model:)
        end
      end
    end
  end
end
