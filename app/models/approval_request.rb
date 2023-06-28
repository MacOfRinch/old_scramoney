class ApprovalRequest < ApplicationRecord
  has_many :approval_statuses

  belongs_to :category
  belongs_to :requester, class_name: 'User', foreign_key: :user_id
  belongs_to :task

  enum status: { waiting: 0, accepted: 1, refused: 2 }
end
