class Category < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :approval_requests

  belongs_to :family, optional: true

  validates :name, presence: true

end
