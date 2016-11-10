module LoginHelper

  def assert_login_form_sound
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

  # Gets log in form, checks session and posts the form.
  def post_login_form(username, password)
    get login_path
    assert session[:user_id].nil?

    post login_path, params: {
      user: username,
      password: password
    }
  end
  # Combines assertions for actions following a successfull log in.
  def assert_login_success(user)
    assert_equal session[:user_id], user.id
    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_template :show
    assert_select "div.flash-success"
    assert_select "td", user.username
  end

  # Combines assertions for actions following a unsuccessfull log in.
  def assert_login_fail(user)
    refute_equal session[:user_id], user.id
    assert_response :success
    assert_template :new
    assert_select "div.flash-error"
  end

  def assert_logout_success
    assert session[:user_id].nil?
    assert_response :redirect
    follow_redirect!
    assert_template :index
    assert_select "div.flash-success"
  end

end
