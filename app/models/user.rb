class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :task_users, dependent: :destroy
  has_many :tasks, through: :task_users
  has_many :approval_requests
  has_many :approval_statuses
  belongs_to :family

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }

  def done(task)
    tasks << task
  end

  def cancel(task)
    task_users.destroy(task)
  end

  def sum_points
    self.tasks.pluck(:points).sum
  end

  def percent
    total = self.family.sum_points
    per = self.sum_points * 100 / total
    per
  end

  def calculate_pocket_money
    total = self.family.budget
    if self.family.sum_points == 0
      pm = (total / self.family.users.size)
    else
      ratio = self.tasks.pluck(:points).sum(0.0) / self.family.sum_points
      pm = total * ratio
    end
    pocket_money = (pm / Unit).to_i * Unit
    pocket_money
  end
end
