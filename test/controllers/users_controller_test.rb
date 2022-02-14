require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # mudei a route do users_new_path para signup_path
  test 'should get sign up' do
    get signup_path
    assert_response :success
    assert_select 'h1', 'Sign up'
  end

  # temos que ter certeza que o ao clicar no botao do signup, sendo este um
  # usuario invalido, nao sera add na db
  # os form gera o params[:user] - vamos simular um user invalido
  # nao esquecer que o post eh feito no users_path (create action) e nao no signup_path (new action)

  test 'add a valid use - should be valid' do
    first_users_count = User.all.count
    post users_path, params: { user: { name: 'Lorenzo',
                                       username: 'losimonassi',
                                       password: 'foobar',
                                       password_confirmation: 'foobar' } }
    second_users_count = User.all.count
    assert_equal (second_users_count - first_users_count), 1
    puts User.first.name
  end

  test 'sucess signup redirects to user show page' do
    # get signup_path
    post users_path, params: { user: { name: 'Lorenzo',
                                       username: 'losimonassi',
                                       password: 'foobar',
                                       password_confirmation: 'foobar' } }
    # it may happen that one controller action redirect to another action in same 
    # or different controller and we need to visit that page to test the further part 
    # of the scenario. Rails provides a handy method follow_redirect! for this purpose.
    # As the name suggests, it follows a redirect response.
    follow_redirect!
    assert_template 'users/show'
  end

  test 'add an invalid user' do
    first_users_count = User.all.count
    post users_path, params: { user: { name: '',
                                       username: 'losimonassi',
                                       password: 'foobar',
                                       password_confirmation: 'foobar' } }
    second_users_count = User.all.count
    assert_equal second_users_count, first_users_count
  end

  test 'unsuccessful signup renders the form again' do
    # get signup_path
    post users_path, params: { user: { name: '',
                                       username: 'losimonassi',
                                       password: 'foobar',
                                       password_confirmation: 'foobar' } }
    # aqui nao ha redirecionamento
    assert_template 'users/new'
  end

  test 'error messagem displayd on users/new when trying do signup invalid user' do
    get signup_path
    post users_path, params: { user: { name: '',
                                       username: 'losimonassi',
                                       password: 'foobar',
                                       password_confirmation: 'foobar' } }
    assert_select 'div[class=?]', 'alert alert-danger'
  end
end
