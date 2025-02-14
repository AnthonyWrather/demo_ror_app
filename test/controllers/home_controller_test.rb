require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "Unauthenticated users should get the home page." do
    get "/"
    assert_response :success
  end
end
