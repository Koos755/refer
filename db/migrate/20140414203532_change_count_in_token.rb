class ChangeCountInToken < ActiveRecord::Migration
  def change
    remove_column :tokens, :count
    add_column :tokens, :count, :integer, default: 0
  end
end
