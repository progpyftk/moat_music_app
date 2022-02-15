# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # mudei a route do users_new_path para signup_path
  test 'should get sign up' do
    get signup_path
    assert_response :success
    assert_select 'h1', 'Sign up'
  end

  test 'valid signup - redirects to user page, show message and increase db' do
    first_users_count = User.all.count
    post users_path, params: { user: { name: 'Lorenzo',
                                       username: 'losimonassi',
                                       password: 'foobar',
                                       password_confirmation: 'foobar' } }
    follow_redirect!
    assert_template 'users/show'
    assert_select 'div[class=?]', 'alert alert-success'
    second_users_count = User.all.count
    assert_equal (second_users_count - first_users_count), 1
    assert is_logged_in? # test helper que testa se esta loggado
  end

  test 'invalid signup - renders form, display alert message , dont change db' do
    first_users_count = User.all.count
    post users_path, params: { user: { name: '',
                                       username: 'losimonassi',
                                       password: 'foobar',
                                       password_confirmation: 'foobar' } }
    second_users_count = User.all.count
    assert_equal second_users_count, first_users_count
    assert_template 'users/new'
    assert_select 'div[class=?]', 'alert alert-danger'
  end
end
