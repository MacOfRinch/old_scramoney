class Task < ApplicationRecord
  has_many :task_users, dependent: :destroy
  has_many :users, through: :task_users
  has_many :approval_requests

  belongs_to :category, optional: true
  belongs_to :family, optional: true

  validates :title, presence: true
  validates :points, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  enum :category_name, {
                        housework: 0,
                        work: 1,
                        school: 2,
                        study: 3,
                        pet: 4,
                        extra: 5
                        }
end
