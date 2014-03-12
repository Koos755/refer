class Wizard
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :mobile, :selling, :buying, :price_range_start, :price_range_end, :lead_id

  validates_presence_of :name
  validates_presence_of :email

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def save(current_user)
    user = User.find_by(email: self.email)
    unless user.present?
      user = User.new
      user.name = self.name
      user.email = self.email
      user.mobile = self.mobile
      user.create_password
      user.save
    end
    lead = Lead.new
    lead.user_id = user.id
    if current_user.agent.present?
      lead.sending_agent_id = current_user.agent.id
    else
      agent = Agent.new
      agent.user_id = current_user.id
      agent.save
      lead.sending_agent_id = agent.id
    end
    lead.selling = self.selling
    lead.buying = self.buying
    lead.price_range_start = self.price_range_start
    lead.price_range_end = self.price_range_end
    lead.save
    self.lead_id = lead.id
  end


end
