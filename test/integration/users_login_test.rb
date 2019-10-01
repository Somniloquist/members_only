require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user_one)
  end

  test "Login with invalid information" do
    get login_path
    assert_template "sessions/new"
    assert_select "form[action='/login']"
    post login_path params: { session: { email: "", password: "" } }
    assert_not flash.empty?, "ERROR: Flash should be not be empty"
    get root_path
    assert flash.empty?, "ERROR: Flash should be empty"
  end

  test "Login with valid information then logout" do
    get login_path
    assert_template "sessions/new"
    assert_select "form[action='/login']"
    post login_path params: { session: { email: @user.email, password: "password" } }
    follow_redirect!
    assert_template "users/show"
    assert logged_in?

    delete logout_path
    follow_redirect!
    assert logged_out?
    assert_template "static_pages/home"
    assert_not flash.empty?
  end

end
