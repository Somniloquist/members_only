require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "successful signup information" do
    get new_user_path
    assert_template "users/new"
    post users_path, params: { user: { username: "testuser",
                                       email: "testuser@example.com",
                                       password: "foobar",
                                       password_confirmation: "foobar" } }
    follow_redirect!
    assert_not flash.empty?
  end
end
