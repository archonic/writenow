class Document < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
  validates :token, presence: true, uniqueness: true
  has_secure_token :token, length: 36

  # has_one :hocuspocus_document, class_name: "Hocuspocus::Document", foreign_key: :token, inverse_of: :document
  # alias_attribute :body, to: :hocuspocus_document

  # def body
  #   Hocuspocus.find_by(name: token).body
  # end
end
