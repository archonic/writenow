# frozen_string_literal: true

module RubyUI
  extend Phlex::Kit
end

module Editor
  extend Phlex::Kit
end

# Allow using RubyUI instead RubyUi
Rails.autoloaders.main.inflector.inflect(
  "ruby_ui" => "RubyUI"
)

# Allow using RubyUI::ComponentName instead Components::RubyUI::ComponentName
Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components/ruby_ui"), namespace: RubyUI
)

# Allow using RubyUI::ComponentName instead RubyUI::ComponentName::ComponentName
Rails.autoloaders.main.collapse(Rails.root.join("app/components/ruby_ui/*"))

# Adding our own Editor phlex components
Rails.autoloaders.main.push_dir(
  Rails.root.join("app/components/editor"), namespace: Editor
)

# Allow using Editor::ComponentName instead Editor::ComponentName::ComponentName
Rails.autoloaders.main.collapse(Rails.root.join("app/components/editor/*"))
