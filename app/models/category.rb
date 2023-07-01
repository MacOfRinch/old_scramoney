class Category < ApplicationRecord
  has_many :tasks
  has_many :approval_requests

  belongs_to :family

  validates :name, presence: true

end
