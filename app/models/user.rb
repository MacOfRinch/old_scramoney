class User < ApplicationRecord
  authenticates_with_sorcery!

  default_scope -> { order(created_at: :asc) }

  mount_uploader :avatar, ImageUploader

  has_many :task_users, dependent: :destroy
  has_many :tasks, through: :task_users
  has_many :approval_requests
  has_many :approval_statuses
  has_many :notices, dependent: :destroy
  has_many :reads, dependent: :destroy
  belongs_to :family

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :reset_password_token, uniqueness: true, allow_nil: true

  def cancel(task)
    task_users.destroy(task)
  end

  def sum_points
    # self.tasks.pluck(:points).sum
    self.task_users.this_month.map{ |record| record.task.points * record.count }.sum
end

  # いい方法見つかったら消す
  def sum_points_of_last_month
    # self.tasks.pluck(:points).sum
    self.task_users.last_month.map{ |record| record.task.points * record.count }.sum
  end

  def percent
    total = self.family.sum_points
    if total == 0
      per = 1 / self.family.users.size
    else
      per = self.sum_points * 100 / total
    end
    per
  end

  def percent_of_last_month
    total = self.family.sum_points_of_last_month
    if total == 0
      per = 1 / self.family.users.size
    else
      per = self.sum_points_of_last_month * 100 / total
    end
    per
  end

  def calculate_pocket_money
    total = self.family.budget
    if self.family.sum_points == 0
      pm = (total / self.family.users.size)
    else
      ratio = self.sum_points.to_f / self.family.sum_points.to_f
      pm = total * ratio
    end
    pocket_money = (pm / Unit).to_i * Unit
    pocket_money
  end

  def calculate_pocket_money_of_last_month
    # こいつが犯人だよ
    total = self.family.budget_of_last_month
    if self.family.sum_points_of_last_month == 0
      pm = (total / self.family.users.size)
    else
      ratio = self.sum_points_of_last_month.to_f / self.family.sum_points_of_last_month.to_f
      pm = total * ratio
    end
    pocket_money = (pm / Unit).to_i * Unit
    pocket_money
  end
end
