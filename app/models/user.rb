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
    tasks.destroy(task)
  end
end
