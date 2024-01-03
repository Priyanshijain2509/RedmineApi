class Issue < ApplicationRecord
  belongs_to :project
  belongs_to :user

  has_many :edit_issues
  
  validates :subject, :start_date, :end_date, presence: true
  validate :end_date_cannot_be_less_than_start_date
  before_create :date_cannot_be_in_the_past

  serialize :assignee, Array
  serialize :issue_status, Array

  private

  def date_cannot_be_in_the_past
    errors.add(:start_date, "can't be in the past") if start_date && start_date < Date.today
    errors.add(:end_date, "can't be in the past") if end_date && end_date < Date.today
  end

  def end_date_cannot_be_less_than_start_date
    if start_date && end_date && end_date < start_date
      errors.add(:end_date, "can't be less than the start date")
    end
  end
end
