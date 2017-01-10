require 'simplecov'
SimpleCov.start

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!
# require 'simplecov'
# SimpleCov.start

require "helpers/session_test_helper"
require "helpers/user_test_helper"

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  include SessionTestHelper
  include UserTestHelper
  # Add more helper methods to be used by all tests here...
end
