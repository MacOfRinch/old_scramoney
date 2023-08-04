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

    default_categories.each do |category|
      new_category = category.dup
      new_category.family_id = self.id
      new_category.save
    end

    default_tasks.each do |task|
      new_task = task.dup
      new_task.family_id = self.id
      case new_task.category_name

      when "housework"
        new_task.category_id = self.categories.find_by(name: '家事').id
      when "work"
        new_task.category_id = self.categories.find_by(name: '仕事').id
      when "school"
        new_task.category_id = self.categories.find_by(name: '学校').id
      when "study"
        new_task.category_id = self.categories.find_by(name: '勉強(科目ごと)').id
      when "pet"
        new_task.category_id = self.categories.find_by(name: 'ペット').id
      when "extra"
        new_task.category_id = self.categories.find_by(name: 'その他').id
      end
      
      new_task.save
    end
  end
end
