class News < ApplicationRecord
  belongs_to :project

  validates :news_title, presence: true, length: { minimum: 3, maximum: 20 }
  validates :news_added_by, presence: true, length: { minimum: 3, maximum: 20 }
  validates :project_id, presence: true
end
