class Notice < ApplicationRecord
  belongs_to :family

  has_many :reads, dependent: :destroy

end
