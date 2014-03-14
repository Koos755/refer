class WizardMail < ActionMailer::Base
  default from: "no-reply@surerefer.com"

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_lead_receiving_agent(lead, token)
    @lead = lead
    @url = token_url(token.value)
    mail( :to => token.user.email,
      :subject => "Real estate referral from #{@lead.sending_agent.user.name}" )
  end

  def send_lead_broker(lead, token)
    @lead = lead
    @token = token
    @url = token_url(token.value)
    mail( :to => token.user.email,
      :subject => "Approval of referral requested" )
  end
end
