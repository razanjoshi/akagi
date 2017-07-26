module Wechat::SessionsHelper

  def log_in
    unless logged_in?
      user_info = $wechat_client.user(session[:weixin_openid]).result
      if user_info.present?
        if user_info[:subscribe] != 1
          user_info = $wechat_client.get_oauth_userinfo(session[:weixin_openid], session[:access_token]).result
          user_info[:subscribe] = 0
        end

        @user = User.create_user(user_info)

      else

        $wechat_client.refresh_token
        user_info = $wechat_client.user(session[:weixin_openid]).result

        render_404 unless user_info.present?
      end
    end

  end

  def current_user
    @current_user ||= User.find_by(weixin_openid: session[:weixin_openid])
  end

  def logged_in?
    !current_user.nil?
  end

  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404 if Rails.env.production?
  end

end
