class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :tasks, through: :task_users
  has_many :task_users
  has_many :approval_requests, as: :requester
  has_many :approval_statuses, as: :approver
  belongs_to :family

  validates :name, presence: true
  validates :email, presence: true
  validates :password, presence: true
end
