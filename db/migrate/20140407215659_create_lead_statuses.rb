class CreateLeadStatuses < ActiveRecord::Migration
  def change
    create_table :lead_statuses do |t|
      t.string :status_string
      t.string :status_number
      t.integer :lead_id

      t.timestamps
    end
  end
end
