# frozen_string_literal: true

module App
  class DialogContent < Components::Base
    DEFAULT_CLASSES = %w[
      app-dialog
      absolute left-[50%] top-[50%] translate-x-[-50%] translate-y-[-50%] w-full max-h-screen
      rounded border-1 border bg-background shadow-lg sm:rounded-lg md:w-full max-w-lg
      p-6
      overflow-y-auto
      duration-200 [open]:animate-in [open]:fade-in-0 :not([open]):animate-out :not([open]):fade-out-0 :not([open]):zoom-out-95 data-[state=open]:zoom-in-95 :not([open]):slide-out-to-left-1/2 :not([open]):slide-out-to-top-[48%] [open]:slide-in-from-left-1/2 [open]:slide-in-from-top-[48%]
    ]

    def initialize(**attrs)
      super(**attrs)
    end

    def view_template(&)
      dialog(**attrs) do
        yield
        close_button
      end
    end

    private

    def default_attrs
      {
        data: {
          app__dialog_target: "dialog"
        },
        class: DEFAULT_CLASSES
      }
    end

    def close_button
      Button(
        variant: :ghost,
        size: :sm,
        class: "absolute end-4 top-4 focus:ring-2 focus:ring-ring focus:ring-offset-2 data-[state=open]:bg-accent data-[state=open]:text-muted-foreground",
        data_action: "app--dialog#close"
      ) do
        svg(
          width: "15",
          height: "15",
          viewbox: "0 0 15 15",
          fill: "none",
          xmlns: "http://www.w3.org/2000/svg",
          class: "h-4 w-4"
        ) do |s|
          s.path(
            d:
                  "M11.7816 4.03157C12.0062 3.80702 12.0062 3.44295 11.7816 3.2184C11.5571 2.99385 11.193 2.99385 10.9685 3.2184L7.50005 6.68682L4.03164 3.2184C3.80708 2.99385 3.44301 2.99385 3.21846 3.2184C2.99391 3.44295 2.99391 3.80702 3.21846 4.03157L6.68688 7.49999L3.21846 10.9684C2.99391 11.193 2.99391 11.557 3.21846 11.7816C3.44301 12.0061 3.80708 12.0061 4.03164 11.7816L7.50005 8.31316L10.9685 11.7816C11.193 12.0061 11.5571 12.0061 11.7816 11.7816C12.0062 11.557 12.0062 11.193 11.7816 10.9684L8.31322 7.49999L11.7816 4.03157Z",
            fill: "currentColor",
            fill_rule: "evenodd",
            clip_rule: "evenodd"
          )
        end
        span(class: "sr-only") { "Close" }
      end
    end
  end
end
