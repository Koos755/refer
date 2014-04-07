class Lead < ActiveRecord::Base

  belongs_to :user
  belongs_to :sending_agent, class_name: "Agent"
  belongs_to :receiving_agent, class_name: "Agent"
  has_many :tokens
  has_many :lead_statuses

end
