require 'test_helper'

class UserDestroyTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.password = "password"
    @another_user = users(:two)

  end

  test "not logged in user can not destroy a profile" do
    get delete_user_path(@user)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'sessions/new'
    assert flash[:error]
    assert_select "div.flash-error"
  end

  test "logged in user can destroy own profile" do

    # Logs in and redirect to own profile page.
    assert_logged_in(@user)
    get delete_user_path(@user)
    assert_response :success

    assert_select "form", action: user_path(@user) do
      assert_select "button", "DELETE"
    end

    assert_difference "User.count", -1 do
      delete user_path(@user)
    end
    assert session[:user_id].nil?
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :index
    assert flash[:success]
    assert_select "div.flash-success"
  end

  test "logged in user can not destroy other profiles" do

    # Logs in and redirect to own profile page.
    assert_logged_in(@user)

    get delete_user_path(@another_user)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :index
    assert flash[:error]
    assert_select "div.flash-error"

    assert_no_difference "User.count" do
      delete user_path(@another_user)
    end
  end
end
