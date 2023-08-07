require "test_helper"

class UnfollowTwitterControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get unfollow_twitter_index_url
    assert_response :success
  end
end
