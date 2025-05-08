# frozen_string_literal: true

module App
  class DialogClose < Components::Base
    def view_template(&)
      RubyUI::Button(
        variant: :ghost,
        size: :sm,
        class: "absolute end-4 top-4 focus:ring-2 focus:ring-ring focus:ring-offset-2 data-[state=open]:bg-accent data-[state=open]:text-muted-foreground",
        data_action: "app--dialog#close"
      ) do
        i(class: "ri-close-large-line")
        span(class: "sr-only") { "Close" }
      end
    end
  end
end
