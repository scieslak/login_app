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
    assert_select "form[method=post][action=?]", users_path do
      assert_select "input" do
        assert_select "[type=text][name=?]", "user[username]"
        assert_select "[type=email][name=?]", "user[email]"
        assert_select "[type=password][name=?]", "user[password]"
        assert_select "[type=password][name=?]", "user[password_confirmation]"
      end
      assert_select "button[type=submit]"
    end
  end

  test "can not register with valid information" do
    assert_difference "User.count", 1 do
    post users_path, params: {
                      user: {
                        username: @newuser.username,
                        email: @newuser.email,
                        password: @newuser.password,
                        password_confirmation: @newuser.password
                      }
    }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :show
    assert_select "p", @newuser.username
  end

  end



end
