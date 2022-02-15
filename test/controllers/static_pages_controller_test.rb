# frozen_string_literal: true

require 'test_helper'

# O que testar?
# 1 - que ao aceessar o root_path vamos ter sucesso
# 2 - que o root path leva de fato para nossa pag inicial que tem o titulo Welcome to the Moat Music App

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'should get home' do
    get root_path
    assert_response :success
    assert_select 'h1', 'Welcome to the Moat Music App'
  end

  test 'links when not logged in' do
    get root_path
    assert_not is_logged_in?
    assert_select 'a[href=?]', login_path
    assert_select 'a[href=?]', signup_path
    assert_select 'a', text: 'Albums', count: 0
    assert_select 'a', text: 'Artists', count: 0
    assert_select 'a', text: 'My Profile', count: 0
    assert_select 'a', text: 'Logout', count: 0
  end

  test 'links when logged in' do
    new_log_in_as(@user, 'password')
    get root_path
    assert is_logged_in?
    assert_select 'a[href=?]', albums_path
    assert_select 'a[href=?]', logout_path
    assert_select 'a', text: 'Log In', count: 0
    assert_select 'a', text: 'Sign Up', count: 0
    assert_select 'a[href=?]', user_path(@user)
  end
end
