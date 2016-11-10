require 'test_helper'

class UserShowTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.password = "password"
    @another_user = users(:two)

  end

  test "not logged in user can not view a profile" do
    get user_path(@user)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template 'sessions/new'
    assert flash[:error]
    assert_select "div.flash-error"
  end

  test "logged in user can view only own profile" do

    # Logs in and redirect to own profile page.
    assert_logged_in(@user)

    # Try to view other user profile
    get user_path(@another_user)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :index
    assert flash[:error]
    assert_select "div.flash-error"
  end
end
