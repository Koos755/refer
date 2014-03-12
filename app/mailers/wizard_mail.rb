class WizardMail < ActionMailer::Base
  default from: "no-reply@surerefer.com"

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for our amazing app' )
  end

  def send_lead_receiving_agent(lead)
    @lead = lead
    mail( :to => @lead.receiving_agent.user.email,
      :subject => "Real estate referral from #{@lead.sending_agent.user.name}" )
  end
end
