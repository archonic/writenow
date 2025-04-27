class Document < ApplicationRecord
  include Sluggable

  validates :token, presence: true, uniqueness: true
  has_secure_token :token, length: 36
end
