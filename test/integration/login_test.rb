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
    assert_response :success
    assert_template :new
    assert_select "form[action=?]", login_path do
      assert_select "input" do
        assert_select "[type=text][name=user]"
        assert_select "[type=password][name=password]"
      end
      assert_select "button[type=submit]", "LOG IN"
    end
  end

  test "can log in with valid username and password" do
    # Gets log in form, checks session and posts the form.
    # See LoginHelper
    post_login_form(@user.username, @user.password)
    # Combines assertions for actions following a successfull log in.
    assert_success_login(@user)
  end

  test "can log in with valid email and password" do
    post_login_form(@user.email, @user.password)
    assert_success_login(@user)
  end

  test "can not log in with invalid username or email" do
    post_login_form("wrongName", @user.password)
    # Combines assertions for actions following a unsuccessfull log in.
    assert_fail_login(@user)
  end
end
