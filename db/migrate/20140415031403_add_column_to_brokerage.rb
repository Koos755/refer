class AddColumnToBrokerage < ActiveRecord::Migration
  def change
    add_column :brokerages, :address, :string
    add_column :brokerages, :zip, :string
  end
end
