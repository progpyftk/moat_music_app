# frozen_string_literal: true

require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'should get new' do
    get sessions_new_url
    assert_response :success
  end

  test 'login with valid info' do
    post login_path, params: { session: { username: @user.username,
                                          password: 'password' } }
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div[class=?]', 'alert alert-success'
    assert_select 'a[href=?]', albums_path
    assert_select 'a[href=?]', logout_path
    assert_select 'a', text: 'Log In', count: 0
    assert_select 'a', text: 'Sign Up', count: 0
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'td', 'Testing Vibes'
    assert_select 'td', 'TesterMan'
  end

  test 'login followed by logout' do
    post login_path, params: { session: { username: @user.username,
                                          password: 'password' } }
    assert is_logged_in?
    delete logout_path
    assert_redirected_to root_url
    assert_not is_logged_in?
  end
end
