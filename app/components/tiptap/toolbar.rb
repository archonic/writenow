# frozen_string_literal: true

module Tiptap
  class Toolbar < Tiptap::Base
    WRAPPER_CLASSES = "flex gap-1 p-1"

    def view_template(&)
      div(**attrs) do
        div(class: "grow flex gap-1") do
          RubyUI::DropdownMenu(options: { placement: "bottom-start" }) do
            DropdownMenuTrigger do
              Tiptap::Button(class: "w-14 inline-flex") do
                div(class: "pr-2", "data-tiptap--editor-target": "blockSelector") { i(class: "ri-heading") }
                i(class: "ri-arrow-down-s-line")
              end
            end
            DropdownMenuContent do
              DropdownMenuLabel { "Hierarchy" }
              DropdownMenuItem(:paragraph) do
                i(class: "ri-paragraph pr-2")
                div { "Paragraph" }
              end
              DropdownMenuSeparator()
              DropdownMenuItem(:heading_1) do
                i(class: "ri-h-1 pr-2")
                div { "Heading 1" }
              end
              DropdownMenuItem(:heading_2) do
                i(class: "ri-h-2 pr-2")
                div { "Heading 2" }
              end
              DropdownMenuItem(:heading_3) do
                i(class: "ri-h-3 pr-2")
                div { "Heading 3" }
              end
              DropdownMenuItem(:heading_4) do
                i(class: "ri-h-4 pr-2")
                div { "Heading 4" }
              end
              DropdownMenuLabel { "Lists" }
              DropdownMenuSeparator()
              DropdownMenuItem(:ul) do
                i(class: "ri-list-unordered pr-2")
                div { "Bullet list" }
              end
              DropdownMenuItem(:ol) do
                i(class: "ri-list-ordered-2 pr-2")
                div { "Ordered list" }
              end
              DropdownMenuLabel { "Blocks" }
              DropdownMenuSeparator()
              DropdownMenuItem(:codeblock) do
                i(class: "ri-code-box-line pr-2")
                div { "Code block" }
              end
              DropdownMenuItem(:blockquote) do
                i(class: "ri-quote-text pr-2")
                div { "Block quote" }
              end
            end
          end
          Tiptap::Button(:bold) { i(class: "ri-bold") }
          Tiptap::Button(:italic) { i(class: "ri-italic") }
          Tiptap::Button(:strike) { i(class: "ri-strikethrough") }
          Tiptap::Button(:link_set) { i(class: "ri-link") }
          Tiptap::Button(:link_unset) { i(class: "ri-link-unlink-m") }
          Tiptap::Button(:attach) { i(class: "ri-attachment-2") }
        end

        div(class: "flex gap-1") do
          Tiptap::Button(:undo) { i(class: "ri-arrow-go-back-line") }
          Tiptap::Button(:redo) { i(class: "ri-arrow-go-forward-line") }
        end
      end
    end

    private

    def default_attrs
      {
        id: "toolbar",
        class: WRAPPER_CLASSES
      }
    end
  end
end
