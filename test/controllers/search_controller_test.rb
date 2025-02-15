require "test_helper"

class SearchControllerTest < ActionDispatch::IntegrationTest
  # test "should get index" do
  #   get search_index_url
  #   assert_response :success
  # end


  test "Unauthenticated users should get redirected." do
    # get search_path("New")
    get "/search?name=New"
    assert_response :redirect
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_match "You need to sign in or sign up", response.body
  end
end
