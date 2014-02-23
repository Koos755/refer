class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.integer :user_id
      t.integer :sending_agent_id
      t.integer :receiving_agent_id
      t.boolean :accepted_by_agent
      t.datetime :accepted_by_agent_time
      t.boolean :accepted_by_broker
      t.datetime :accepted_by_broker_time
      t.boolean :selling
      t.boolean :buying
      t.integer :price_range_start
      t.integer :price_range_end

      t.timestamps
    end
  end
end
