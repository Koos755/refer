class AddReferralToLead < ActiveRecord::Migration
  def change
    add_column :leads, :referral_percent, :integer
  end
end
