class Blog::SitemapsController < ApplicationController

  def index
    @posts = Post.all
    @cases = Case.all
  end

end
