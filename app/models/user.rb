class User < ActiveRecord::Base
  has_secure_password

  has_one :agent, :dependent => :destroy
  has_one :broker, :dependent => :destroy
  has_many :leads, :dependent => :destroy
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def create_password
    password = SecureRandom.urlsafe_base64(8)
    self.password = password
    self.password_confirmation = password
    self.save
  end

  def create_with_agent
    agent = Agent.new
    agent.user_id = self.id
    agent.save
  end
end
