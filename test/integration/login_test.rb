require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test "user can fill log in" do

    get root_path
    assert_response :success
    assert_select "a[href=?]", login_path

    get login_path
    assert_response :success
    assert_template :new
    assert_select "form[action=?]", login_path

  end
end
