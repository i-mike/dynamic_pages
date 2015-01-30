class PageContent < ActiveRecord::Base
  belongs_to :language
  belongs_to :page

  validates :title,
            presence: true,
            length: { in: 1..200 }

  validates :body,
            presence: true

  validates_associated :page

  validates_associated :language

end
