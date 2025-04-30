class Document < ApplicationRecord
  include Sluggable
  self.filter_attributes += [ :body ]

  validates :token, presence: true, uniqueness: true
  has_secure_token :token, length: 36
  validates :name, presence: true, length: 1..100
end
