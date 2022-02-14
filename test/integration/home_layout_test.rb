require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

    # quando nao estiver logado devemos ter apenas o login e signup link
  test "layout links when NOT LOGGED IN" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", signup_path, count: 2
    assert_select "a[href=?]", login_path
  end


end