require 'test_helper'

class LogoutTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.password = "password"
  end

  test "can log in and out" do

    post_login_form(@user)
    assert_login_success(@user)

    assert_select "a[href=?]", logout_path

    delete logout_path
    assert_logout_success

  end
end
