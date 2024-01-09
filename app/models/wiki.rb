class Wiki < ApplicationRecord
  belongs_to :project
  belongs_to :user, foreign_key: 'created_by', class_name: 'User'

  validates :project_id, presence: true
  validates_uniqueness_of :project_id

end
