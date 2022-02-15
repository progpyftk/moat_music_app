# frozen_string_literal: true

require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @admin_user = users(:user_admin)
  end

  test 'not logged user cant visit album list then login and checks albums list' do
    get albums_path
    assert_not is_logged_in?
    follow_redirect!
    assert_template 'static_pages/home'
    assert_select 'div[class=?]', 'alert alert-warning'
    new_log_in_as(@user, 'password')
    follow_redirect!
    assert is_logged_in?
    assert_template 'users/show'
  end

  test 'number of albums added by user must be equal delete buttoms' do
    get albums_path
    new_log_in_as(@user, 'password')
    get albums_path
    assert_select 'td a', 'Delete', count: @user.albums.count
  end

  test 'admin user can delete all albums' do
    get albums_path
    new_log_in_as(@admin_user, 'password')
    get albums_path
    assert_select 'td a', 'Delete', count: Album.all
  end
end
