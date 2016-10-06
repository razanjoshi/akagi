require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
    def setup
        @user = users(:Michael)
        @other_user = users(:Noel)
    end

    test "should redirect index when not logged in" do
        get users_path
        assert_redirected_to login_url
    end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "your editing should not pass before login" do
      get edit_user_path(@user)
      assert_redirected_to login_url
      assert_not flash.empty?
      patch user_path(@user),params:{user:{name:"Ragna The Bloodedge",
                                  email:"ragna@thebloodedge.com",
                                  password:"password",
                                  password_confirmation:"password"}}
      assert_redirected_to login_url
      assert_not flash.empty?
  end

  test "your editing should not pass beacuse you are not the one" do
      log_in_as(@other_user)
      get edit_user_path(@user)
      assert_redirected_to @user
      assert_not flash.empty?
      patch user_path(@user), params: { user: { name: @user.name,
                                        email: @user.email } }
      assert_not  flash.empty?
      assert_redirected_to @user
  end

  test "should not allow the admin attribute to be edited via the web" do
      log_in_as(@other_user)
      assert_not @other_user.admin?
      patch user_path(@other_user),params:{
                            user:{name:"Ragna The Bloodedge",
                            email:"ragna@thebloodedge.com",
                            admin:"1"}}
        @other_user.reload
        assert_not @other_user.admin?
  end
  
  test "should redirect destroy when not logged in " do
      assert_no_difference 'User.count' do
          delete user_path(@user)
      end
      assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
      log_in_as(@other_user)
      assert_no_difference "User.count" do
          delete user_path(@user)
      end
      assert_redirected_to root_url
  end

end
