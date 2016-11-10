require 'test_helper'

class UserEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @user.password = "password"
    @another_user = users(:two)

  end

  test "can not edit prfile without log in first" do
    get edit_user_path(@user)
    assert_response :redirect
    follow_redirect!
    assert_template 'sessions/new'
    assert flash[:error]
    assert_select "div.flash-error"
  end

  test "logged in user can edit own profile with valid information" do

    user_id = @user.id
    new_email = "new@email.com"

    assert_logged_in(@user)
    get edit_user_path(@user)
    assert_response :success
    assert_user_form_sound("UPDATE", @user)
    @user.email = new_email
    patch_user_form(@user)
    assert_response :redirect
    follow_redirect!
    assert_template :show
    assert flash[:success]
    assert_select "div.flash-success"

    assert_equal User.find(user_id).email, new_email
  end


  test "user can not edit own profile with invalid information" do

    user_id = @user.id
    new_email = "new@email.com"

    assert_logged_in(@user)
    get edit_user_path(@user)
    assert_response :success
    assert_user_form_sound("UPDATE", @user)
    @user.email = new_email
    patch_user_form(@user, :fail)
    assert_response :success
    assert_template :edit
    assert flash[:error]
    assert_select "div.flash-error"

    refute_equal User.find(user_id).email, new_email
  end



  test "logged in user can not edit other users profiles" do

    assert_logged_in(@user)
    get edit_user_path(@another_user)
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :index
    assert flash[:error]
    assert_select "div.flash-error"
  end
end
