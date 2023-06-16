class ApprovalStatus < ApplicationRecord
  belongs_to :approval_request
  belongs_to :user

  enum status: { waiting: 0, accept: 1, refuse: 2 }
end
