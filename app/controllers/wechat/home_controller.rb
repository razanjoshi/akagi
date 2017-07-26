class Wechat::HomeController < Wechat::BaseController

  #before_action :log_in

  def index
    @cases = Case.find_by(id:1).subcases.limit(5)
  end

  private
  def set_case
    @case = Case.find_by(id: params[:id])
  end

  def reply_param
    params.require('post').permit(:nickname,:content)
  end

end
