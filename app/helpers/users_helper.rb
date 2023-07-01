module UsersHelper
  def nickname
    self.nickname.present? ? self.nickname : self.name
  end
end
