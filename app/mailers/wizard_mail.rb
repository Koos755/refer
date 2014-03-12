class WizardMail < ActionMailer::Base
  default from: "no-reply@surerefer.com"

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end
end
