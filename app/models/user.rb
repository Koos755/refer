class User < ActiveRecord::Base

  has_secure_password

  has_one :agent, :dependent => :destroy
  has_one :broker, :dependent => :destroy
  has_many :leads, :dependent => :destroy
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  before_save :clean_mobile

  def create_password
    password = SecureRandom.urlsafe_base64(8)
    self.password = password
    self.password_confirmation = password
    self.auto_password = true
    self.save
  end

  def create_with_agent
    agent = Agent.new
    agent.user_id = self.id
    agent.save
  end

  def create_with_broker(brokerage_name, lead)
    brokerage = Brokerage.new
    brokerage.name = brokerage_name
    brokerage.save
    broker = Broker.new
    broker.user_id = self.id
    broker.brokerage_id = brokerage.id
    broker.save
    agent = lead.receiving_agent
    agent.brokerage_id = brokerage.id
    agent.save
  end

  def clean_mobile
    if self.mobile.present?
      self.mobile = self.mobile.gsub(/\D/, '')
    end
  end
end
