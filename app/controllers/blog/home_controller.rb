class Blog::HomeController < Blog::BaseController

  def index
    @posts = uniclown.posts.paginate(page: params[:page], per_page: 10)
    if logged_in?
      @post = current_user.posts.build(case_id:1)
    end
  end

  def bar
    @cases = Case.paginate(page: params[:page], per_page: 5)
  end

  def about
    @content = fileread('md/loveletter.md')
  end

  def contact
  end


end
