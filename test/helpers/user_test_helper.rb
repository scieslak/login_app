module UserTestHelper

  def assert_user_form_sound(button_value, user=nil)
    id = user.id unless user.nil?
    assert_select "form[method=post]", action: /\/#{users_path}(\/#{id})?/ do
      assert_select "input" do
        assert_select "[type=text][name=?]", "user[username]"
        assert_select "[type=email][name=?]", "user[email]"
        assert_select "[type=password][name=?]", "user[password]"
        assert_select "[type=password][name=?]", "user[password_confirmation]"
      end
      assert_select "button[type=submit]", button_value
    end
  end

  def post_user_form(user, action = :pass)
    user.email = "wrongEmail" if action == :fail
    post users_path, params: {
                      user: {
                        username: user.username,
                        email: user.email,
                        password: user.password,
                        password_confirmation: user.password
                      }
    }
  end

  def patch_user_form(user, action = :pass)
    user.email = "wrongEmail" if action == :fail
    patch user_path(user), params: {
                      user: {
                        username: user.username,
                        email: user.email,
                        password: user.password,
                        password_confirmation: user.password
                      }
    }
  end

end
