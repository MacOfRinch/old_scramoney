module ApplicationHelper
  def page_title(page_title='')
    base_title = 'Scramoney'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def display_family_name(family)
    family.nickname.present? ? family.nickname : "#{family.name} 家"
  end
end
