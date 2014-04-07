class LeadStatus < ActiveRecord::Base

  belongs_to :lead
  validates :lead_id, presence: true
  validates :status_string, presence: true, inclusion: { in: ["Client contacted", "Working with client", "Offer accepted", "Sale closed", "Commission received", "Referral fee received", "Void"], message: "%{value} is not a valid status" }
  validates :status_number, presence: true, inclusion: { in: 1..7, message: "%{value} is not a valid status number" }

end
