class StaticPagesController < ApplicationController

  def home
      if logged_in?
          @micropost = current_user.microposts.build
          @feed_items = current_user.feed.paginate(page: params[:page])
          store_location
      end
  end

  def bar
      @cases = Case.all

  end

  def about
      @content = fileread('md/loveletter.md')
  end

  def contact
  end




end
