class Page < ActiveRecord::Base
  attr_accessor :pc

  has_many :pages, foreign_key: :parent_id
  has_many :page_contents, dependent: :delete_all
  has_closure_tree order: "priority"

  validates :slug,
            presence: true,
            format: { with: /\A[\w-]*\z/, message: 'Invalid slug' },
            uniqueness: true

  validates :priority,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :cannot_be_enabled_unless_default_localization_provided,
           :cannot_be_parent_to_own_child


  scope :enabled, -> { where(enabled: true) }
  scope :most_first, -> { roots.enabled.order(priority: :desc).take }

  scope :with_localized_content, -> do
    joins("LEFT JOIN (SELECT  id, title, body, page_id, language_id FROM  page_contents) pc ON pc.id = (
                        SELECT ppc.id FROM page_contents ppc
                        WHERE pages.id = ppc.page_id AND (language_id = #{Language.current.id} or language_id = #{Language.default.id})
                        ORDER BY language_id = #{Language.default.id}
                        LIMIT 1
                      )").select("pages.*, pc.title as localized_title, pc.body as localized_body").includes(:page_contents).group("pages.id")
  end

  scope :localized, -> (language, default_language) do
    includes(page_contents: :language).where(page_contents: { language_id: [language.id, default_language.id] })
  end

  def to_param
    slug
  end

  private

    def cannot_be_enabled_unless_default_localization_provided
      if enabled? and page_contents.where(page_contents: { language_id: Language.default.id }).first.nil?
        errors.add(:enabled, "can't be enabled unless default localization provided")
      end
    end

    def cannot_be_parent_to_own_child
      if persisted?
        if self.parent_id and Page.find(self.id).self_and_descendants.include? Page.find(self.parent_id)
          errors.add(:parent, "can not be parent to own child")
        end
      end
    end
end
