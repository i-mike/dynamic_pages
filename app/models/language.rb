class Language < ActiveRecord::Base

  scope :current, -> { find_by_slug(I18n.locale) }
  scope :default, -> { find_by_slug(I18n.default_locale) }

  validates :slug,
            presence: true,
            format: { with: /\A[a-z]{2}\z/, message: 'Bad slug' }

  validates :name,
            presence: true

  def self.available_languages
    Language.all.map { |l| l.slug }
  end


end
