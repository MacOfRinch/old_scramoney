class Category < ApplicationRecord
  has_many :tasks
  has_many :approval_requests

  validates :name, presence: true

end
