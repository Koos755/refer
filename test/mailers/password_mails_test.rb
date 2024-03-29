require 'test_helper'

class PasswordMailsTest < ActionMailer::TestCase
  test "forgot_password" do
    mail = PasswordMails.forgot_password
    assert_equal "Forgot password", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "email_unknown" do
    mail = PasswordMails.email_unknown
    assert_equal "Email unknown", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
