class Project < ApplicationRecord
  belongs_to :user
  
  serialize :assigned_to, Array
end
