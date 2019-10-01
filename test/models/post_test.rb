require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    user = users(:test_user_one)
    @post = Post.new(title: "title", body: "body", user: user)
  end

  test "test post should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = ''
    assert_not @post.valid?
  end

  test "body should be present" do
    @post.body = ''
    assert_not @post.valid?
  end

  test "title should not exceed max length" do
    @post.title = "a" * 256
    assert_not @post.valid?
  end
end
