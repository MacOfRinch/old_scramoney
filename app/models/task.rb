class Task < ApplicationRecord
  has_many :users, through: :task_users
  belongs_to :category

  
end
