class Blog::CasesController < Blog::BaseController

  before_action :logged_in_user, only: [:new, :create, :edit, :destroy]

  def new
    if logged_in?
      @case = current_user.cases.build
    end
  end

  def index
    @cases = Case.paginate(page: params[:page], per_page: 10)
  end

  def show
    @case = Case.find_by(id: params[:id])
    @posts = @case.posts.paginate(page: params[:page], per_page: 10)
    if logged_in?
      @post = current_user.posts.build(case_id: @case.id)
    end
  end

  def create
    @case = current_user.cases.build(case_params)
    if params[:info][:bangumi].length > 0
      bangumi(@case,params[:info][:bangumi])
    end
    if @case.save
      @case.father(params[:father_id])
      flash[:success] = "创建成功！"
      redirect_to @case
    else
      render 'new'
    end
  end

  def edit
    @case = Case.find(params[:id])
  end

  def update
    @case = Case.find(params[:id])
    if @case.update_attributes(case_params)
      flash[:success] = "更新成功，请继续履行救世主的义务"
      redirect_to @case
    else
      render 'edit'
    end
  end

  def destroy
    @case = current_user.cases.find_by(id: params[:id])
    redirect_to root_url if @case.nil?
    @case.destroy
    flash[:success] = "记录已销毁"
    redirect_to root_url
  end



  private
  def case_params
    params.require(:case).permit(:body,:title,:tag_list)
  end

  def bangumi(newcase,bgm_url)
    #发送get请求到bgmurl
    url = URI(bgm_url)
    body = Net::HTTP.get(url)
    body = Nokogiri::HTML(body)
    body = body.css('div#bangumiInfo')
    newcase.body = body
    #从request中提取信息
    #将提取到的信息保存到case.body中
  end


end
