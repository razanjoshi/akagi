require 'net/http'
class Blog::SessionsController < ApplicationController

  layout 'blog_login'
  include Blog::SessionsHelper

  def new
  end

  def create

    @user = User.find_by(email: session_params[:email].downcase)
    if @user && @user.authenticate(session_params[:password])
      log_in User.first
      redirect_back_or root_url
    else
      flash.now[:notice] = "错误的召唤阵"
      render :new
    end
  end

  def authorize
    json = weibo_gettoken(params[:code])
    session[:access_token] = json['access_token']

    @user = User.find_by(weibo:json['uid'])
    if json['uid'].nil?
      flash.now[:noitce] = "有点不好使，请联系我"
      redirect_to blog_login_path and return
    end
    if @user
      userinfo = weibo_userinfo(@user)
      @user.update avatar:userinfo['avatar_hd']
      log_in @user
      redirect_back_or root_url
    else
      @user = User.new(weibo:json['uid'])
      json = weibo_userinfo(@user)
      @user.name = json['name']
      @user.save(validate: false)
      log_in @user
      redirect_back_or root_url
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def session_params
    params.require(:session).permit(:email, :password, :remember_me)
  end

  def weibo_gettoken(code)
    params = {
              client_id: "2957192072",
              client_secret: "55874c06581fcc40e9d083c15f984197",
              grant_type: "authorization_code",
              redirect_uri: "#{Settings.visit_url}/login/authorized",
              code: code
              }
    uri = URI("https://api.weibo.com/oauth2/access_token")
    res = Net::HTTP.post_form(uri,params)
    token = JSON(res.body)
  end

  def weibo_userinfo(user)
    uri = URI("https://api.weibo.com/2/users/show.json")
    params = {uid:user.weibo,
                      access_token:session[:access_token]}
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    json = JSON(res.body)
  end



end
