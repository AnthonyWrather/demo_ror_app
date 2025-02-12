require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get :home
    assert_response :success
  end

  test "should get index too" do
    get static_pages_home_url
    assert_response :success
  end
end
