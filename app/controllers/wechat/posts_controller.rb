class Wechat::PostsController < Wechat::BaseController

  #before_action :log_in
  before_action :set_case


  def new
    @post = @case.posts.build(nickname: Settings.nicknames.sample, types:3)
  end

  def create
    @post = @case.posts.build post_param
    if @post.nickname == '麻仓月轩'
      @post.user = User.first
    end
    if @post.photos
      @post.photos.each do |photo|
        md = '  ![](' + photo.image + ')'
        @post.content = @post.content + md
      end
    end
    @post.save
    redirect_to [:wechat,  @case]
  end

  def more
    @posts = @case.posts.paginate(page: params[:page], per_page: 5)
    render partial: '/wechat/cases/post', collection: @posts, as: :post
  end


  private
  def set_case
    @case = Case.find_by(id: params[:id])
  end

  def post_param
    params.require('post').permit(:nickname, :content, :types, photos_attributes:[:image])
  end

end
