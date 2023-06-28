class Family < ApplicationRecord
  has_many :users

  def sum_points
    points = 0
    self.users.each do |user|
      if user.tasks.present?
        user.tasks.each do |task|
          points += task.points
        end
      end
    end
    points
  end

end
