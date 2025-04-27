class Document < ApplicationRecord
  include SlugReusable

  validates :token, presence: true, uniqueness: true
  has_secure_token :token, length: 36
end
