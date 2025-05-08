# frozen_string_literal: true

module Documents
  class Preview < Components::Base
    include Phlex::Rails::Helpers::Routes
    attr_reader :model

    def initialize(model:, **attrs)
      @model = model
      super(**attrs)
    end

    def view_template(&)
      article(class: "flex flex-col border-1 rounded-lg shadow aspect-12/19 hover:bg-slate-100 hover:border-sky-700 transition-colors") do
        header(class: "grow") do # "h-[calc(100%---spacing(4))]"
          h4(class: "text-lg font-semibold h-full rounded-lg rounded-b-none") do
            a(href: document_path(model), class: "block size-full p-5") do
              @model.name
            end
          end
        end
        footer(class: "flex flex-row justify-between border-t-1 border-gray-100 text-gray-500 items-center p-5") do
          div(class: "flex flex-row gap-2 text-sm") do
            i(class: "ri-hourglass-fill")
            div { "22 mins" }
          end
          # Maybe we want an action menu here
          # Button(variant: :ghost, size: :sm) do
          #   i(class: "ri-more-line")
          # end
        end
      end
    end
  end
end
