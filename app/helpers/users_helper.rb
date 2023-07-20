module UsersHelper
  def display_name(user)
    user.nickname.present? ? user.nickname : user.name
  end
end
