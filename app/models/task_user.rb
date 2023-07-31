class TaskUser < ApplicationRecord
  belongs_to :task
  belongs_to :user

  # enum :count_name, { counts: 0, hours: 1 }
  validates :count, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  scope :this_month, -> { where(created_at: Time.now.beginning_of_month..Time.now.end_of_month) }
  scope :last_month, -> { where(created_at: Time.now.prev_month.beginning_of_month..Time.now.prev_month.end_of_month) }
end
