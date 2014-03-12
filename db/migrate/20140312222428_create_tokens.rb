class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :value
      t.string :type
      t.integer :user_id
      t.integer :lead_id

      t.timestamps
    end
  end
end
