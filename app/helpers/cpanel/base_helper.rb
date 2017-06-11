module Cpanel::BaseHelper

  def top_c_navbar(str)
    top_c_home(str) +  top_c_case(str)
  end

  def top_c_home(str)
    cls = "home" == str ? "active" : ""
    content_tag :li, class: cls do
      link_to "Home", "/cpanel/"
    end
  end


  def top_c_case(str)
    cls = "cases" == str ? "active" : ""
    content_tag :li, class: cls do
      link_to "地球图书馆", [:cpanel, :cases]
    end
  end


  def active_sidebar_class(path, alias_path = "")
    current_page?(path) ? 'active' : ''
  end

end
