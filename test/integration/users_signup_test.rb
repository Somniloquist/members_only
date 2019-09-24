require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "successful signup information" do
    get new_user_path
    assert_template "users/new"
  end
end
