require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    # @user.password = 'password'
  end


  # username validation tests

  test "user is valid" do
    # flunk("Message #{@user.password_digest}, #{@user.email}")
    assert @user.valid?
  end

  test "username must be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  test "username should contain minimum 3 characters" do
    @user.username = "uu"
    assert_not @user.valid?
  end

  test "username should contain maximum 50 characters" do
    @user.username = "u" * 51
    assert_not @user.valid?
  end

  test "username should contain only letters numbers underscores" do
    name = %w{ n@me
                   n\ am!
                   n#me
                   u$er
                   ^%name
                   **name**
                   ?name
                   <name>
                   (name)
                   === }

    name.each do |invalid_name|
      @user.username = invalid_name
      assert_not @user.valid?, "#{invalid_name} should not be valid."
    end
  end


end
