# https://gorails.com/episodes/friendlyid-history
module SlugReusable
  extend ActiveSupport::Concern
  class ReusableSlugGenerator < FriendlyId::SlugGenerator
    def available?(slug)
      if @config.uses?(::FriendlyId::Reserved) && @config.reserved_words.present? && @config.treat_reserved_as_conflict
        return false if @config.reserved_words.include?(slug)
      end

      # Look only at the active slugs in use
      !@scope.unscoped.where(slug: slug).exists?
    end
  end

  included do
    extend FriendlyId
    friendly_id :name, use: [ :slugged, :history ], slug_generator_class: ReusableSlugGenerator

    validates :name, presence: true
    validates :slug, presence: true, uniqueness: true
  end
end
