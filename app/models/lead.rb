class Lead < ActiveRecord::Base

  include SaveExtentions

  belongs_to :user
  belongs_to :sending_agent, class_name: "Agent"
  belongs_to :receiving_agent, class_name: "Agent"
  has_many :tokens
  has_many :lead_statuses
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user
  has_one :broker, through: :receiving_agent
  has_one :brokerage, through: :broker

  def accepted?
    if self.accepted_by_agent && self.accepted_by_broker
      return true
    else
      return false
    end
  end
end
