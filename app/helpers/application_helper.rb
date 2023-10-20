module ApplicationHelper

  require 'rqrcode'
  require 'chunky_png'

  def page_title(page_title='')
    base_title = 'Scramoney'
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def display_family_name(family)
    family.nickname.present? ? family.nickname : "#{family.name} 家"
  end

  def show_qrcode(url)
    if Rails.env.production?
      qrcode = RQRCode::QRCode.new("https://scramoney-e5c31290853e.herokuapp.com#{url}")
    elsif Rails.env.development? || Rails.env.test?
      qrcode = RQRCode::QRCode.new("http://localhost:3000#{url}")
    end
    return ChunkyPNG::Image.from_datastream(qrcode.as_png.resize(200,200).to_datastream).to_data_url
  end
end
