require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test_user_one)
  end

  def log_in_as(user, password: "password" )
    post login_path params: { session: { email: user.email,
                                         password: password } }
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

end
