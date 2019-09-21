require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:test_user_one)
  end

  test "Test user should be valid" do
    assert @user.valid?
  end

  test "Username should be present" do
    @user.username = " " * 8
    assert_not @user.valid?
  end

  test "Email should be present" do
    @user.email = " " * 8
    assert_not @user.valid?
  end

  test "Username should be unique" do
    user_two = @user.dup
    user_two.username = @user.username.upcase
    user_two.email = "test_user_two@example.com"
    @user.save

    assert_not user_two.valid?
  end

  test "Email should be unique" do
    user_two = @user.dup
    user_two.email =  @user.email.upcase
    user_two.username = "test_user_two"
    @user.save

    assert_not user_two.valid?
  end

  test "username should be limited to 15 characters or less" do
    @user.username = "a" * 16
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid}"
    end
  end

  test "email validation should reject invalid addresses" do
     invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid? "#{invalid_address.inspect} should be invalid"
    end
  end

end
