module Wechat::CasesHelper

  def case_banner_for thecase
    if thecase.photos.empty?
      image_tag 'table.jpg'
    else
      image_tag thecase.photos.first.image
    end
  end


end
