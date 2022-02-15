# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def is_logged_in?
      !session[:user_id].nil?
    end

    # Log in as a particular user.
    def log_in_as(user)
      session[:user_id] = user.id
    end

    def new_log_in_as(user, password)
      post login_path, params: { session: { username: user.username, password: password } }
    end

    # Add more helper methods to be used by all tests here...
  end
end
