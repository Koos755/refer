class Agent < ActiveRecord::Base

  belongs_to :user
  delegate :name, to: :user
  delegate :mobile, to: :user
  delegate :email, to: :user

end
