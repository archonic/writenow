class Document < ApplicationRecord
  validates :name, :description, presence: true

  has_rich_text :body
end
