require 'test_helper'

class UsersEditTestTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:Michael)
        @other_user = users(:Noel)
    end

    test "unsuccessful edit" do
        log_in_as(@user)
        get edit_user_path(@user)
        assert_template 'users/edit'
        patch user_path(@user),params:{user:{name:"",
                                        email:"foo@vaild",
                                        password:"foo",
                                        password_confirmation:"bar"}}
        assert_template 'users/edit'
        assert_select 'div.field_with_errors',count:8
    end

    test "successful edit with friendly forwarding" do
        get edit_user_path(@user)
        assert_not session[:forwarding_url].nil?
        assert_redirected_to login_path
        log_in_as(@user)
        assert_redirected_to edit_user_path(@user)
        follow_redirect!
        assert_template 'users/edit'
        assert session[:forwarding_url].nil?
        #
        patch user_path(@user),params:{user:{name:"Ragna The Bloodedge",
                                    email:"ragna@thebloodedge.com",
                                    password:"password",
                                    password_confirmation:"password"}}
        assert_redirected_to @user
        @user.reload

        assert_not flash.empty?
        assert_equal "Ragna The Bloodedge", @user.reload.name
        assert_equal "ragna@thebloodedge.com", @user.reload.email
    end


end
