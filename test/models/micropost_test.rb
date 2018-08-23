require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

    def setup
        @user = users(:Noel)
        @case = cases(:one)
        @micropost = Micropost.new(content:"Lorem ipsum", user_id: @user.id,case_id: @case.id)
    end

    test "should be valid" do
        assert @micropost.valid?
    end

    test "user id should be present" do
        @micropost.user_id = nil
        assert_not @micropost.valid?
    end

    test "case id should be present" do
        @micropost.case_id = nil
        assert_not @micropost.valid?
    end



    test "content should be present" do
        @micropost.content = " "
        assert_not @micropost.valid?
    end



    test "order should be most recent first" do
        assert_equal microposts(:most_recent), Micropost.first
    end
end
