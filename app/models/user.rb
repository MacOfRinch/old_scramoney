# frozen_string_literal: true

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
    task_users.this_month.map { |record| record.task.points * record.count }.sum
  end

  # いい方法見つかったら消す
  def sum_points_of_last_month
    # self.tasks.pluck(:points).sum
    task_users.last_month.map { |record| record.task.points * record.count }.sum
  end

  def percent
    total = family.sum_points
    if total.zero?
      1 / family.users.size
    else
      sum_points * 100 / total
    end
  end

  def percent_of_last_month
    total = family.sum_points_of_last_month
    if total.zero?
      1 / family.users.size
    else
      sum_points_of_last_month * 100 / total
    end
  end

  # 端数を加味して最も次の1,000円単位に近い人から足していって、お小遣い額合計がちょうど予算になるようにできるだけ調整するメソッドだよ。
  def calculate_pocket_money
    sum_of_rounded_down_pm = family.users.sum { |user| user.calculate_rounded_down_pocket_money[:rounded_down] }
    difference = ((family.budget / Unit) * Unit - sum_of_rounded_down_pm) / Unit
    pocket_money = calculate_rounded_down_pocket_money[:rounded_down]
    if difference >= 1
      list = []
      family.users.each do |user|
        element = user.calculate_rounded_down_pocket_money[:diff]
        list << element
      end
      rounded_up_list = list.max(difference)
      selected_users = family.users.select do |user|
        rounded_up_list.include?(user.calculate_rounded_down_pocket_money[:diff])
      end
      pocket_money += Unit if selected_users.include?(self) && difference >= selected_users.size
    end
    pocket_money
  end

  # 1,000円単位で切り捨てたお小遣い額と切り捨てた額をハッシュ形式で返すメソッドだよ。
  def calculate_rounded_down_pocket_money
    total = family.budget
    if family.sum_points.zero?
      pm = (total / family.users.size)
    else
      ratio = sum_points.to_f / family.sum_points
      pm = total * ratio
    end
    rounded_down = (pm / Unit).to_i * Unit
    { rounded_down:, diff: (pm - rounded_down) }
  end

  def calculate_pocket_money_of_last_month
    sum_of_rounded_down_pm = family.users.sum do |user|
      user.calculate_rounded_down_pocket_money_of_last_month[:rounded_down]
    end
    count = ((family.budget_of_last_month / Unit) * Unit - sum_of_rounded_down_pm) / Unit
    pocket_money = calculate_rounded_down_pocket_money_of_last_month[:rounded_down]
    if count >= 1
      list = []
      family.users.each do |user|
        element = user.calculate_rounded_down_pocket_money_of_last_month[:diff]
        list << element
      end
      rounded_up_list = list.max(count)
      selected_users = family.users.select do |user|
        rounded_up_list.include?(user.calculate_rounded_down_pocket_money_of_last_month[:diff])
      end
      pocket_money += Unit if selected_users.include?(self)
    end
    pocket_money
  end

  def calculate_rounded_down_pocket_money_of_last_month
    # こいつが犯人だよ
    total = family.budget_of_last_month
    if family.sum_points_of_last_month.zero?
      pm = (total / family.users.size)
    else
      ratio = sum_points_of_last_month.to_f / family.sum_points_of_last_month
      pm = total * ratio
    end
    rounded_down = (pm / Unit).to_i * Unit
    { rounded_down:, diff: (pm - rounded_down) }
  end
end
