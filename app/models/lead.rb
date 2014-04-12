class Lead < ActiveRecord::Base

  belongs_to :user
  belongs_to :sending_agent, class_name: "Agent"
  belongs_to :receiving_agent, class_name: "Agent"
  has_many :tokens
  has_many :lead_statuses
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user
  has_one :broker, through: :receiving_agent

end
