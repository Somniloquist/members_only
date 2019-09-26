require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "successful signup information" do
    get new_user_path
    assert_template "users/new"
    assert_select "form[action='/signup']"
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "testuser",
                                        email: "testuser@example.com",
                                        password: "foobar",
                                        password_confirmation: "foobar" } }
    end
    follow_redirect!
    assert_not flash.empty?
  end

  test "invalid signup information" do
    get new_user_path
    assert_template "users/new"
    assert_select "form[action='/signup']"
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "",
                                        email: "invalid@email",
                                        password: "foo",
                                        password_confirmation: "bar" } }
    end
    assert_template "users/new"
    assert_select "div.field_with_errors>input", 4
  end
end
