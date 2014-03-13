class Brokerage < ActiveRecord::Base

  has_many :agents
  has_one :broker

end
