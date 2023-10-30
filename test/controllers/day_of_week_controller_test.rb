require "test_helper"

class DayOfWeekControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get day_of_week_index_url
    assert_response :success
  end
end
