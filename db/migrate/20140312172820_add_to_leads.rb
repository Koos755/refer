class AddToLeads < ActiveRecord::Migration
  def change
    add_column :leads, :accepted_terms, :datetime
  end
end
