class WizardMail < ActionMailer::Base
  default from: '"SureRefer" <no-reply@surerefer.com>'

  def send_signup_email(user)
    @user = user
    mail( :to => @user.email,
    :subject => 'Thanks for signing up for SureRefer' )
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
      :subject => "#{@lead.receiving_agent.name}'s referral needs your approval" )
  end

  def lead_accepted(lead)
    @lead = lead
    @receiving_agent = @lead.receiving_agent
    @sending_agent = @lead.sending_agent
    @broker = @receiving_agent.broker
    @url = lead_url(@lead)
    mail( :to => "#{@receiving_agent.email},#{@sending_agent.email},#{@broker.email}",
      :subject => "#{@sending_agent.name}/#{@receiving_agent.name} referral accepted" )
  end

end
