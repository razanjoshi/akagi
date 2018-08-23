class Blog::PostsController < Blog::BaseController

  before_action :logged_in_user ,only:[:create,:destroy,:edit,:update]
  before_action :correct_user, only: :destroy
  before_action :set_post, only:[:show, :edit, :update]

  def create
    @post = current_user.posts.build post_params
    if @post.save
      @post.case.update_attribute(:updated_at,Time.zone.now)
      if params[:is_share] == "1"
        weibo_share @post
      end
      flash[:success] = "发表成功!"
    else
      flash[:notice] = "失败!"
    end
    if @post.case_id == 1
      redirect_to root_url
    else
      redirect_to [:blog, @post.case]
    end
  end

  def index
    @tags = Post.tag_counts_on(:tags)
    @tag = params[:tag]
    @posts = Post.tagged_with(@tag).paginate(page: params[:page], per_page: 10)
  end

  def edit

  end

  def update
    if @post.update_attributes(post_params)
      @post.case.update_attribute(:updated_at,Time.zone.now)
      flash[:notice] = "更新成功，请继续履行救世主的义务"
      redirect_to @post.case_id == 1 ? root_url : [:blog, @post.case]
    else
      render 'edit'
    end
  end

  def show
    if !params["alone"].present?
      @next = Post.where("id > ?", @post.id).first
      @prev = Post.where("id < ?", @post.id).first
    end
  end

  def destroy
      @post.destroy
      flash[:success] = "post deleted"
      redirect_back(fallback_location: root_url)
  end


  private
  def post_params
    params.require(:post).permit(:content, :picture, :case_id, :tag_list, photos_attributes:[:image])
  end

  def correct_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_url if @post.nil?
  end

  def set_post
    @post = Post.find_by(id: params[:id])
  end
end
