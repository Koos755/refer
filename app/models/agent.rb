class Agent < ActiveRecord::Base

  belongs_to :user
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user
  belongs_to :brokerage
  has_one :broker, :through => :brokerage
  has_many :leads_send, foreign_key: "sending_agent_id", class_name: "Lead"
  has_many :leads_received, foreign_key: "receiving_agent_id", class_name: "Lead"

end
