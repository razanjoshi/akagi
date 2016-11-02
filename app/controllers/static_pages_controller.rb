class StaticPagesController < ApplicationController

  def home
      if logged_in?
          @micropost = current_user.microposts.build
          @feed_items = current_user.feed.paginate(page: params[:page],per_page: 10)
          store_location
      end
  end

  def bar
      @cases = Case.paginate(page: params[:page],per_page: 5)
  end

  def about
      @content = fileread('md/loveletter.md')
  end

  def contact
  end




end
