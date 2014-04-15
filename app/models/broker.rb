class Broker < ActiveRecord::Base

  include SaveExtentions

  belongs_to :user
  belongs_to :brokerage
  has_many :agents, :through => :brokerage
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user
  has_many :leads, through: :agents

end
