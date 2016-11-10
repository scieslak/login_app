require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @user.password = "password"
  end

  test "user can find and fill  log in form" do
    get root_path
    assert_response :success
    assert_select "a[href=?]", login_path
    get login_path
    assert_login_form_sound
  end

  test "can log in with valid username and password" do
    post_login_form(@user.username, @user.password)
    assert_login_success(@user)
  end

  test "can log in with valid email and password" do
    post_login_form(@user.email, @user.password)
    assert_login_success(@user)
  end

  test "can not log in with invalid username or email" do
    post_login_form("wrongName", @user.password)
    assert_login_fail(@user)
  end

  test "can not log in with invalid password" do
    post_login_form(@user.email, "wrongPassword")
    assert_login_fail(@user)
  end

end
