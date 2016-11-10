require 'test_helper'

class UserRegistrationTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.password = "password"
    @newuser = User.new(username: "newuser", email: "new@example.com", password: @user.password, password_confirmation: @user.password)

  end

  test "can fill registration form" do

    get root_path
    assert_response :success
    assert_select "a[href=?]", new_user_path

    get new_user_path
    assert_response :success
    assert_user_form_sound("REGISTER")
  end

  test "can register with valid information" do
    assert_difference "User.count", 1 do
      post_user_form(@newuser)
    end
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :show
    assert_select "td", @newuser.username
  end

  test "can not register with invalid information" do
    assert_no_difference "User.count" do
      post_user_form(@newuser, :fail)
    end

    assert_template :new
    assert_user_form_sound("REGISTER")
  end



end
