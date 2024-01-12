class Project < ApplicationRecord
  belongs_to :user

  has_many :issues, dependent: :destroy
  has_one :project_wiki, class_name: 'Wiki', dependent: :destroy
  has_many :news, dependent: :destroy

  has_rich_text :project_description
  validates_uniqueness_of :identifier

  serialize :assigned_to, Array
end
