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

  attr_accessor :invite_token

  def send_invite_email
    UserMailer.invitation(self).deliver_now
  end

  def create_invite_digest
    self.invite_token = '腹筋板チョコバレンタイン！'
    update_attributes(invite_digest: User.digest(invite_token), invite_sent_at: Time.zone.now)
  end

# 有効期限切れでtrue返すで
  def invitation_expired?
    self.invite_sent_at < 24.hours.ago
  end

  def cancel(task)
    task_users.destroy(task)
  end

  def sum_points
    # self.tasks.pluck(:points).sum
    self.task_users.map{ |record| record.task.points * record.count }.sum
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
      ratio = self.sum_points.to_f / self.family.sum_points.to_f
      pm = total * ratio
    end
    pocket_money = (pm / Unit).to_i * Unit
    pocket_money
  end
end
