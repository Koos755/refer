class PasswordMails < ActionMailer::Base
  default from: '"SureRefer" <no-reply@surerefer.com>'

  def forgot_password(user, token)
    @user = user
    @url = token_url(token.value)
    mail( :to => @user.email,
    :subject => 'Password Reset Request' )
  end

  def email_unknown(email)
    @url = step1_url
    mail( :to => email,
    :subject => 'You are not registered yet!' )
  end
end
