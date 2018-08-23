require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:Noel)
        ActionMailer::Base.deliveries.clear
    end


    test "I want to live in this world in the infinity alone" do
        get new_password_reset_path
        assert_template 'password_resets/new'
        #电子邮件地址无效
        post password_resets_path, params:{password_reset:{email:''
                                    }}
        assert_template 'password_resets/new'
        assert_not flash.empty?
        #电子邮件有效
        post password_resets_path, params:{password_reset:{email:@user.email}}
        assert_not flash.empty?
        assert_redirected_to root_url
        #发送1封邮件
        assert_equal 1, ActionMailer::Base.deliveries.size
        #重设摘要更新
        assert_not_equal @user.reset_digest,@user.reload.reset_digest
        #密码重设表单
        user = assigns(:user)
        #错误的重设令牌
        get edit_password_reset_path('wrong token',email:user.email)
        assert_redirected_to root_url
        #错误的邮箱
        get edit_password_reset_path(user.reset_token,email:'wrong email')
        assert_redirected_to root_url
        #用户未激活
        user.toggle!(:activated)
        get edit_password_reset_path(user.reset_token,email:user.email)
        assert_redirected_to root_url
        user.toggle!(:activated)
        #正确的邮箱和令牌
        get edit_password_reset_path(user.reset_token,email:user.email)
        assert_template 'password_resets/edit'
        #隐藏的邮箱
        assert_select "input[name=email][type=hidden][value=?]",user.email
        #密码和密码确认不匹配
        patch password_reset_path(user.reset_token),params:{email:user.email,
                                        user:{password:'foobar',
                                    password_confirmation:'barfoo'}}
        assert_select 'div#error_explanation'
        #空的密码
        patch password_reset_path(user.reset_token),params:{email:user.email,
                                        user:{password:'',
                                    password_confirmation:''}}
        assert_select 'div#error_explanation'
        #重设成功
        patch password_reset_path(user.reset_token),params:{email:user.email,
                                        user:{password:'foobar',
                                    password_confirmation:'foobar'}}
        assert_redirected_to user_path(user)
        assert is_logged_in?
        assert_not flash.empty?
    end

        test "expired token" do
            get new_password_reset_path
        post password_resets_path, params:{password_reset:{email:@user.email}}
            @user = assigns(:user)
            @user.update_attribute(:reset_sent_at, 3.hours.ago)
            patch password_reset_path(@user.reset_token),
                params:{ email:@user.email,
                    user:{password:"foobar",
                        password_confirmation:"foobar"}}
            assert_response :redirect
            follow_redirect!
            assert_match /expire/i, response.body
        end
end
