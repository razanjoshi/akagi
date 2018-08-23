class AccountActivationsController < ApplicationController

    def edit
        user = User.find_by(email:params[:email])
        if user && !user.activated? && user.authenticated?(:activation,params[:id])
            user.activate
            log_in user
            flash[:success] = "召唤成功，欢迎来到UNICLOWN THE WORLD"
            redirect_to user
        else
            flash[:danger] = "召唤无效"
            redirect_to root_url
        end
    end




end
