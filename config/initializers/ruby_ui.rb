# frozen_string_literal: true

module RubyUI
  extend Phlex::Kit
end

module Tiptap
  extend Phlex::Kit
end

module Documents
  extend Phlex::Kit
end

# Allow using RubyUI instead RubyUi
Rails.autoloaders.main.inflector.inflect(
  "ruby_ui" => "RubyUI"
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components/ruby_ui"), namespace: RubyUI
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components/tiptap"), namespace: Tiptap
)

Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components/documents"), namespace: Documents
)

# Allow using Namespace::ComponentName instead Components::Namespace::ComponentName
Rails.autoloaders.main.collapse(Rails.root.join("app/components/ruby_ui/*"))
Rails.autoloaders.main.collapse(Rails.root.join("app/components/documents/*"))
Rails.autoloaders.main.collapse(Rails.root.join("app/components/tiptap/*"))
