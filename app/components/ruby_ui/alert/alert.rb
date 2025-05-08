# frozen_string_literal: true

module RubyUI
  class Alert < Base
    def initialize(variant: nil, **attrs)
      @variant = variant
      super(**attrs) # must be called after variant is set
    end

    def view_template(&)
      div(**attrs, &)
    end

    private

    def colors
      case @variant
      when nil
        "ring-border bg-muted/20 text-foreground [&>i]:opacity-80"
      when :warning
        "ring-warning/20 bg-warning/5 text-warning [&>i]:text-warning/80"
      when :success
        "ring-success/20 bg-success/5 text-success [&>i]:text-success/80"
      when :destructive
        "ring-destructive/20 bg-destructive/5 text-destructive [&>i]:text-destructive/80"
      end
    end

    def default_attrs
      base_classes = "backdrop-blur relative w-full ring-1 ring-inset rounded-lg px-4 py-4 text-sm [&>i+div]:translate-y-[-3px] [&>i]:absolute [&>i]:start-4 [&>i]:top-4 [&>i~*]:ps-8"
      {
        class: [ base_classes, colors ]
      }
    end
  end
end
