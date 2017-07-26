class Wechat::CasesController < Wechat::BaseController

  #before_action :log_in
  before_action :set_case, only:[:index, :show]

  def index
    @cases = Case.find_by(id:1).subcases
  end

  def new
    @case = Case.find_by(id:1).subcases.build(nickname: Settings.nicknames.sample, types:3)
  end

  def create
    @case = Case.find_by(id:1).subcases.build case_param
    if @case.nickname == '麻仓月轩'
      @case.user = User.first
    end
    @case.save
    redirect_to [:wechat,  @case]
  end



  def show
    @post = @case.posts.build(nickname: Settings.nicknames.sample, types:3)
  end



  private
  def set_case
    @case = Case.find_by(id: params[:id])
  end

  def case_param
    params.require(:case).permit(:nickname,:content, :title, :types, photos_attributes:[:image])
  end

end
