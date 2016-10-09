class StaticPagesController < ApplicationController
  def home
      if logged_in?
          @micropost = current_user.microposts.build
          @feed_items = current_user.feed.paginate(page: params[:page])
      end
  end

  def bar
      @feed_items = User.first.feed.paginate(page: params[:page])
  end

  def about
  end

  def contact
  end
end
