module Blog::BaseHelper

  def full_title(page_title = '')
    base_title = "Akagi Project On UniClown"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def top_b_navbar(str)
    top_b_home(str) + top_b_post(str) + top_b_login(str)
  end

  def top_b_home(str)
    cls = "home" == str ? "menu-item active" : "menu-item"
    content_tag :li, {class: cls, roll: 'presentation'} do
      link_to "Home", "/blog/"
    end
  end

  def top_b_case(str)
    cls = "cases" == str ? "menu-item active" : "menu-item"
    content_tag :li, {class: cls, roll: 'presentation'} do
      link_to "最近动向", [:blog, :cases]
    end
  end

  def top_b_post(str)
    cls = "posts" == str ? "menu-item active" : "menu-item"
    content_tag :li, {class: cls, roll: 'presentation'} do
      link_to "世界之树", "/blog/posts"
    end
  end

  def top_b_login(str)
    cls = "login" == str ? "menu-item active" : "menu-item"
    content_tag :li, {class: cls, roll: 'presentation'} do
      if logged_in?
        link_to "地球图书馆", '/cpanel'
      else
        link_to "那么，来细数你的罪恶吧", [:blog, :login]
      end
    end
  end

  def get_tags
    tags = Post.tag_counts_on(:tags)
    content_tag :div, class:'tagcloud' do
      tags.each do |tag|
        concat(link_to tag, [:blog, :posts, tag: tag])
      end
    end
  end

  def get_latest_posts
    posts = Post.take(3);
  end

  def get_latest_images
    posts = Photo.take(9);
  end
end
