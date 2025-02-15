require "test_helper"

class NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "Unauthenticated users should get redirected." do
    get notifications_url
    assert_response :redirect
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_match "You need to sign in or sign up", response.body
  end
end
