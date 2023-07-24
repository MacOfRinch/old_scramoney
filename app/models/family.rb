class Family < ApplicationRecord

  mount_uploader :avatar, ImageUploader

  before_create -> { while self.id.blank? || Family.find_by(id: self.id).present? do
                      self.id = format("%0#{16}d", SecureRandom.random_number(10**16))
                    end }

  has_many :users
  has_many :tasks
  has_many :categories

  validates :budget, presence: true

  def sum_points
    points = 0
    self.users.each do |user|
      if user.task_users.present?
        user.task_users.each do |record|
          points += record.task.points * record.count
        end
      end
    end
    points
  end

end
