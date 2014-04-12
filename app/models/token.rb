class Token < ActiveRecord::Base

  belongs_to :user
  belongs_to :lead

  validates :token_type, presence: true, inclusion: { in: %w(lead_agent lead_broker password_reset), message: "%{value} is not a valid token_type" }

  def create_lead_broker_token(lead)
    self.create_token
    self.token_type = 'lead_broker'
    self.save
  end

  def create_lead_agent_token(lead)
    self.create_token
    self.token_type = 'lead_agent'
    self.user_id = lead.receiving_agent.user.id
    self.lead_id = lead.id
    self.save
  end

  def create_lead_broker_token(lead, user)
    self.create_token
    self.token_type = 'lead_broker'
    self.user_id = user.id
    self.lead_id = lead.id
    self.save
    WizardMail.send_lead_broker(lead, self).deliver
  end

  def create_token
    self.value = SecureRandom.urlsafe_base64(50)
  end
end
