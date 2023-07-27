class Family < ApplicationRecord

  mount_uploader :avatar, ImageUploader

  before_create -> { while self.id.blank? || Family.find_by(id: self.id).present? do
                      self.id = format("%0#{16}d", SecureRandom.random_number(10**16))
                    end }

  has_many :users, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :notices, dependent: :destroy

  validates :budget, presence: true

  def sum_points
    points = 0
    self.users.each do |user|
      if user.task_users.this_month.present?
        user.task_users.this_month.each do |record|
          points += record.task.points * record.count
        end
      end
    end
    points
  end

  # いい方法見つかったら消す
  def sum_points_of_last_month
    points = 0
    self.users.each do |user|
      if user.task_users.last_month.present?
        user.task_users.last_month.each do |record|
          points += record.task.points * record.count
        end
      end
    end
    points
  end
  
end
