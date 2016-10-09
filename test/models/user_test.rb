require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
        @user = User.new(name:"Example User", email:"user@example.com", password:"foobar",password_confirmation:"foobar")
    end

    test "should be valid" do
        assert @user.valid?
    end

    test "name should be present" do
        @user.name = "   "
        assert_not @user.valid?
    end

    test "email should be present" do
        @user.email = "   "
        assert_not @user.valid?
    end

    test "name should not be too long" do
        @user.name = "a"*51
        assert_not @user.valid?
    end

    test "email should not be too long" do
        @user.email = "a"*2444 + "@example.com"
        assert_not @user.valid?
    end

    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                    first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            assert @user.valid?, "#{valid_address.inspect} should be valid"
        end
    end

    test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
      end
    end

    test "email addresses should be unique" do
        duplicate_user = @user.dup
        @user.save
        assert_not duplicate_user.valid?
    end

    test "email addresses should be downcase" do
        @user.email = "USER@EXAMPLE.COM"
        @user.save
        assert @user.email == "user@example.com"
    end

    test "password should not be present(nonblank)" do
        @user.password = @user.password_confirmation = " " * 6
        assert_not @user.valid?
    end

    test "password should not be too short" do
        @user.password = @user.password_confirmation = "a" * 5
        assert_not @user.valid?
    end

    test "associated microposts should be destroyed" do
        @user.save
        @user.microposts.create!(content:"Lorem ipsum")
        assert_difference "Micropost.count", -1 do
            @user.destroy
        end
    end

    test "should follow an unfollow a user"do
        Michael = users(:Michael)
        Noel = users(:Noel)
        assert_not Michael.following?(Noel)
        Michael.follow(Noel)
        assert Michael.following?(Noel)
        assert Noel.followers.include?(Michael)
        Michael.unfollow(Noel)
        assert_not Michael.following?(Noel)
    end

    test "feed should have the right posts" do
        michael = users(:Michael)
        archer = users(:Archer)
        noel = users(:Noel)
        #关注的用户发布的微博
        michael.microposts.each do |post_following|
            assert noel.feed.include?(post_following)
        end
        #自己的微博
        noel.microposts.each do |post_following|
            assert noel.feed.include?(post_following)
        end
        ##为关注的微博
        archer.microposts.each do |post_following|
            assert_not noel.feed.include?(post_following)
        end
    end




end
