class MicropostsController < ApplicationController
    before_action :logged_in_user ,only:[:create,:destroy,:edit,:update]
    before_action :correct_user, only: :destroy

    def create
        @micropost = current_user.microposts.build(micropost_params)
        @micropost.case_id = params[:case_id]

        if @micropost.save

                #@micropost.picture.nil? ? weibo_post(params) : weibo_upload(params)

            flash[:success] = "发表成功!"
            redirect_back_or root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end

    end

    def edit
        @micropost = current_user.microposts.find_by(id: params[:id])
    end

    def update
        @micropost = current_user.microposts.find_by(id: params[:id])
        if @micropost.update_attributes(micropost_params)
            flash[:success] = "更新成功，请继续履行救世主的义务"
            redirect_to root_url
        else
            render 'edit'
        end
    end



    def destroy
        @micropost.destroy
        flash[:success] = "Micropost deleted"
        redirect_back(fallback_location: root_url)
    end

    private

        def micropost_params
            params.require(:micropost).permit(:content,:picture,:case_id)
        end

        def correct_user
            @micropost = current_user.microposts.find_by(id: params[:id])
            redirect_to root_url if @micropost.nil?
        end
end
