require "test_helper"


# O que testar?
# 1 - que ao aceessar o root_path vamos ter sucesso
# 2 - que o root path leva de fato para nossa pag inicial que tem o titulo Welcome to the Moat Music App 

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "h1", "Welcome to the Moat Music App"
  end

end
