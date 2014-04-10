class AddAutoToUser < ActiveRecord::Migration
  def change
    add_column :users, :auto_password, :boolean
  end
end
