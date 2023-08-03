class Family < ApplicationRecord

  after_create :copy_default_categories_and_tasks

  mount_uploader :avatar, ImageUploader

  before_create -> { while self.id.blank? || Family.find_by(id: self.id).present? do
                      self.id = format("%0#{16}d", SecureRandom.random_number(10**16))
                    end }

  has_many :users, dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :task_users, dependent: :destroy

  validates :budget, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1000 }

  # 先月末時点のbudgetを求めるメソッドだよ。未完成だよ。
  def budget_of_last_month
    last_month_end = Time.now.prev_month.end_of_month

  end

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

  def copy_default_categories_and_tasks
    default_tasks = Task.where(family_id: nil)
    default_categories = Category.where(family_id: nil)

    default_tasks.each do |task|
      self.tasks.create(name: task.name, description: task.description, points: task.points, category_id: task.category_id, family_id: 0)
    end

    default_categories.each do |category|
      self.categories.create(name: category.name, family_id: 0)
    end
  end
end
