class StaticPagesController < ApplicationController

  def home
      if logged_in?
          @micropost = current_user.microposts.build
          @feed_items = current_user.feed.paginate(page: params[:page])
      end
  end

  def bar
      @feed_items = Micropost.all.paginate(page: params[:page])
  end

  def about
      @content = markdown('md/loveletter.md')
  end

  def contact
  end




end
