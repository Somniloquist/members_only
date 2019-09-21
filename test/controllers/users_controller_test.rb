require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:test_user_one)
  end

  test "should get new" do
    get new_user_path
    assert_response :success
  end

  test "should get create" do
    post users_path
    assert_response :success
  end

  test "should get show" do
    get user_path(@user)
    assert_response :success
  end
end
