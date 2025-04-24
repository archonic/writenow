class Document < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  has_secure_token :token, length: 36

  has_rich_text :body
end
