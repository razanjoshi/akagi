module Blog::CasesHelper

  def case_content_for(thecase)
    image_count = 0
    markdown(thecase.content).to_s.lines.each_with_index do |line, index|
      if image_count < 1 and line.include?('img')
        concat(sanitize line)
        image_count = image_count +1
      end
    end
  end

  def case_family_for(post)
    content_tag :div do
      post.case.get_family.each do |acase|
        concat(link_to(acase.title+'', [:blog, acase]))
        concat('->')
      end
      concat(link_to('详情', [:blog, post]))
    end
  end

end
