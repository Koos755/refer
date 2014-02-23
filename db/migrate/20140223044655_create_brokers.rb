class CreateBrokers < ActiveRecord::Migration
  def change
    create_table :brokers do |t|
      t.integer :user_id
      t.integer :brokerage_id

      t.timestamps
    end
  end
end
