class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.integer :user_id
      t.integer :brokerage_id

      t.timestamps
    end
  end
end
