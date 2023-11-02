# frozen_string_literal: true

module UsersHelper
  def display_name(user)
    (user.nickname.presence || user.name)
  end
end
