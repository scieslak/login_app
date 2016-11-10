module LoginHelper

  def post_login_form(username, password)
    get login_path
    assert session[:user_id].nil?

    post login_path, params: {
      user: username,
      password: password
    }
  end

  def assert_success_login(user)
    assert_equal session[:user_id], user.id
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :show
    assert_select "div.flash-success"
    assert_select "td", user.username
  end

  def assert_fail_login(user)
    refute_equal session[:user_id], user.id
    assert_response :success
    assert_template :new
    assert_select "div.flash-error"
  end


end
