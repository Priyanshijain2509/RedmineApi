class Project < ApplicationRecord
  belongs_to :user
  has_many :issues, dependent: :destroy

  serialize :assigned_to, Array
end
