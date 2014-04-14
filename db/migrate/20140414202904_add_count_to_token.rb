class AddCountToToken < ActiveRecord::Migration
  def change
    add_column :tokens, :count, :integer
  end
end
