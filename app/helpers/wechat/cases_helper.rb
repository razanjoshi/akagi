module Wechat::CasesHelper

  def case_banner_for thecase
    if thecase.photos.empty?
      image_tag 'table.jpg'
    else
      image_tag thecase.photos.first.image
    end
  end

  def wechat_desc_for_case thecase
    if thecase.posts.count == 0
      desc = thecase.get_nickname + '发布了'+ thecase.title
    else
      desc = thecase.posts.first.get_nickname + '发表了新的回复'
    end
  end

end
