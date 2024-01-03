class EditIssue < ApplicationRecord
  belongs_to :issue

  validates :updated_by, presence: true
  validates :project_id, presence: true
  validates :issue_id, presence: true
end
