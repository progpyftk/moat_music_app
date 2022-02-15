# frozen_string_literal: true

require 'test_helper'

class AlbumsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end
end
