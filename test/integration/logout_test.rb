require 'test_helper'

class LogoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.password = "password"
  end

  test "can log in and out" do

    # Gets log in form, checks session and posts the form.
    # See LoginHelper
    post_login_form(@user.username, @user.password)
    # Combines assertions for actions following a unsuccessfull log in.
    assert_login_success(@user)

    assert_select "a[href=?]", logout_path
    delete logout_path
    # Combines assertions for actions following a unsuccessfull log out.
    assert_logout_success

  end
end
