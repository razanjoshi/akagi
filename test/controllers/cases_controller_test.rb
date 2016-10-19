require 'test_helper'

class CasesControllerTest < ActionDispatch::IntegrationTest

    def setup
        @user = users(:Noel)

    end




  test "should get new with logged_in" do
      get new_case_path
      assert_redirected_to login_url
      assert_not flash.empty?
      log_in_as(@user)
      get new_case_path
      assert_template "cases/new"
  end

  test "should get edit" do

  end

end
