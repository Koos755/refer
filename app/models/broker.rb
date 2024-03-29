class Broker < ActiveRecord::Base

  include SaveExtentions

  belongs_to :user
  belongs_to :brokerage
  has_many :agents, :through => :brokerage
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user
  has_many :leads_sent, through: :agents
  has_many :leads_received, through: :agents

end
