class Broker < ActiveRecord::Base

  belongs_to :user
  belongs_to :brokerage
  has_many :agents, :through => :brokerage
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user

end
