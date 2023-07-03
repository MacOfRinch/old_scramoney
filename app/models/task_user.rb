class TaskUser < ApplicationRecord
  belongs_to :task
  belongs_to :user

  enum :count_name, { counts: 0, hours: 1 }
end
