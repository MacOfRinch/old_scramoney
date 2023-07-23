class Family < ApplicationRecord

  mount_uploader :avatar, ImageUploader
  attribute :uuid, :string, default: -> { SecureRandom.uuid }

  # before_create -> { self.id = SecureRandom.uuid }

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
