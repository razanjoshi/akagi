class SessionsController < ApplicationController

  def new
  end

  def create
      user = User.find_by(email: session_params[:email].downcase)
      if user && user.authenticate(session_params[:password])

              log_in user
              redirect_to user
      else
          flash.now[:danger] = "无效的用户名或者密码错误"
          render 'new'
      end
  end

  def destroy
      session.delete(:user_id)
      redirect_to root_url
  end

  private
    def session_params
        params.require(:session).permit(:email, :password)
    end
end
