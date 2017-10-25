module Blog::BaseHelper

  def full_title(page_title = '')
    base_title = "Akagi Project In UniClown"
    if page_title.empty?
        base_title
    else
        page_title + " | " + base_title
    end
  end

  def top_b_navbar(str)
    top_b_home(str) +   top_b_case(str) + top_b_login(str)
  end

  def top_b_home(str)
    cls = "home" == str ? "active" : ""
    content_tag :li, class: cls do
      link_to "Home", "/blog/"
    end
  end


  def top_b_case(str)
    cls = "cases" == str ? "active" : ""
    content_tag :li, class: cls do
      link_to "最近动向", [:blog, :cases]
    end
  end

  def top_b_login(str)
    cls = "login" == str ? "active" : ""
    content_tag :li, class: cls do
      if logged_in?
        link_to "地球图书馆", '/cpanel'
      else
        link_to "那么，来细数你的罪恶吧", [:blog, :login]
      end
    end
  end




end
