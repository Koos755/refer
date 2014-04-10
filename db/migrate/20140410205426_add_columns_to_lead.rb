class AddColumnsToLead < ActiveRecord::Migration
  def change
    add_column :leads, :location, :string
    add_column :leads, :comment, :text
  end
end
