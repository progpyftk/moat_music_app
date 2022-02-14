require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
 
  # mudei a route do users_new_path para signup_path
  test 'should get sign up' do
    get signup_path
    assert_response :success
    assert_select 'h1', "Sign up"
  end

end
