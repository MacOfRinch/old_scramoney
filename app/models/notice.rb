class Notice < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :family

  has_many :reads, dependent: :destroy

end
