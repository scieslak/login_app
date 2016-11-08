require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @another_user = users(:two)
    @user.password = 'password'
  end


  # username validation tests

  test "user is valid" do
    # flunk("Message #{@user.password_digest}, #{@user.email}")
    assert @user.valid?
  end

  test "username must be present" do
    @user.username = "   "
    assert_not @user.valid?
  end

  test "username should contain minimum 3 characters" do
    @user.username = "uu"
    assert_not @user.valid?
  end

  test "username should contain maximum 50 characters" do
    @user.username = "u" * 51
    assert_not @user.valid?
  end

  test "username should contain only letters numbers underscores" do
    name = %w{ n@me
                   n\ am!
                   n#me
                   u$er
                   ^%name
                   **name**
                   ?name
                   <name>
                   (name)
                   === }

    name.each do |invalid_name|
      @user.username = invalid_name
      assert_not @user.valid?, "#{invalid_name} should not be valid."
    end
  end

  test "username should be unique" do
    @user.save
    @another_user.username = @user.username
    assert_not @another_user.valid?
  end


  # email validation tests

  test "email should be present" do
    @user.email = "  "
    assert_not @user.valid?
  end

  test "email should not be  longer than 255 characters" do
    domain = "@example.com"
    @user.email = "u" * (256 - domain.length) + domain
    assert_not @user.valid?
  end

  test "ivalid email should not pass the validation" do
   invalid_addresses = %w[exa\ mple@example.com
                          exa,mple@example.com
                          exa!mple@example.com
                          exa\ mple,exa!mple@example.com
                          exa_mple_at_example.com
                          example@example\ com
                          example@example,com
                          eample@exa_mple.com
                          example@example.c
                          exa\ mple,exa!mple_at_exa_mple.c]

    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address} should not be valid!"
    end
  end

  test "valid email should pass the validation" do
    valid_addresses = %w[example@example.com
                       exa-mple@example.com
                       exa.mple@example.com
                       exa_mple@example.com
                       exa+mple@example.com
                       123example@example.com
                       eXample@example.com
                       123eXa+mple.exa_mple-exa+mple@example.com
                       example@exa-mple.com
                       example@123example.example.com
                       example@eXample.com
                       123eXa+mple.exa_mple-exa+mple@123.eX-ample.com]

    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address} should be valid!"
    end
  end

  test "email should be stored downcase" do
    mix_case_email = "ExAmPlE@ExAmPlE.CoM"
    @user.email = mix_case_email
    @user.save
    assert_equal mix_case_email.downcase, @user.reload.email
  end

  test "email should be unique" do
    @user.save
    @another_user.email = @user.email
    assert_not @another_user.valid?
  end

  # Password validations tests

  test "password should have minimum 6 characters" do
    @user.password = "p" * 5
    assert_not @user.valid?
  end

  test "matching paswword and confirmation should be valid" do
    @user.password = @user.password_confirmation = "password"
    assert @user.valid?
  end

  test "not matching password and confirmation should not be valid" do
    @user.password = "password"
    @user.password_confirmation = "PASSWORD"
    assert_not @user.valid?
  end
  
  test "password without confirmaton should be not valid" do
      @user.password = "password"
      @user.password_confirmation =""
      assert_not @user.valid?
  end





end
