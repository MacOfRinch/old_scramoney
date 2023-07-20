class Task < ApplicationRecord
  has_many :task_users, dependent: :destroy
  has_many :users, through: :task_users
  has_many :approval_requests

  belongs_to :category
  belongs_to :family

  validates :title, presence: true
  validates :points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end
