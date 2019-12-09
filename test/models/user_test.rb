require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = User.new(name: "Chosu Riki", email: "kuttemina@tobuzo.com",
                     password: "chosu", password_confirmation: "chosu")
  end

  test "should be valid" do
    @user.save
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "    "
    assert_not @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end
  #email validation section
  test "email should not be too long" do
    @user.email = "a" * 244 + "@tobuzoooo.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_DHDH@foo.bar.org
                         first.last@foo.jp alice_bob@boz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.jp user.name@example.
                           foo@bar_baz.com foo@bar+bar.com user@foo..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be downcase" do
    random_case_email = "FOo@exAMple.Com"
    @user.email = random_case_email
    @user.save
    assert_equal random_case_email.downcase, @user.reload.email
  end

  #password validation section


end
