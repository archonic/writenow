# frozen_string_literal: true

class Components::Base < Phlex::HTML
  include Components # needed?
  include RubyUI
  include App
  include Tiptap
  TAILWIND_MERGER = ::TailwindMerge::Merger.new.freeze unless defined?(TAILWIND_MERGER)

  # Include any helpers you want to be available across all components
  include Phlex::Rails::Helpers::Routes
  include Phlex::Rails::Helpers::DOMID
  include Phlex::Rails::Helpers::TurboFrameTag

  if Rails.env.development?
    def before_template
      comment { "Start #{self.class.name}" }
      super
    end

    def after_template
      comment { "End #{self.class.name}" }
      super
    end
  end

  attr_reader :attrs

  def initialize(**user_attrs)
    @attrs = mix(default_attrs, user_attrs)
    @attrs[:class] = TAILWIND_MERGER.merge(@attrs[:class]) if @attrs[:class]
  end

  private

  def default_attrs
    {}
  end
end
