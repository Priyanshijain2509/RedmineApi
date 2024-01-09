class Project < ApplicationRecord
  belongs_to :user
  has_many :issues, dependent: :destroy
  has_one :project_wiki, class_name: 'Wiki', dependent: :destroy
  has_many :news, dependent: :destroy

  serialize :assigned_to, Array
end
