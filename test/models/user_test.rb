# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Lorenzo Testing',
                     username: 'losimonassi',
                     password: 'foobar',
                     password_confirmation: 'foobar',
                     admin: false)

    @old_user = User.new(name: 'Old User',
                         username: 'olduser',
                         password: 'foobar',
                         password_confirmation: 'foobar',
                         admin: false)
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'wrong password_confirmation - should be invalid' do
    @user.password_confirmation = 'wrongpassword'
    assert_not @user.valid?
  end

  test 'password length - should be invalid' do
    @user.password = '12345'
    @user.password_confirmation = '12345'
    assert_not @user.valid?
  end

  test 'missing name - should be invalid' do
    @user.name = ''
    assert_not @user.valid?
  end

  test 'missing username - should be invalid' do
    @user.username = ''
    assert_not @user.valid?
  end

  test 'alrady taken username - should be invalid' do
    @old_user.valid?
    @old_user.save
    @user.username = 'olduser'
    assert_not @user.valid?
    puts @user.errors.messages
  end

  test 'username cant be case sensitive - should be valid' do
    @old_user.valid?
    @old_user.save
    @user.username = @old_user.username.upcase
    assert_not @user.valid?
    puts @user.errors.messages
  end

  test 'before_save downcasing user - should be valid' do
    upcased_username = 'UseRNAmE'
    @user.username = upcased_username
    @user.save
    # usar o reload para ter certeza que pegou da DB
    assert_equal upcased_username.downcase, @user.reload.username
  end
end
