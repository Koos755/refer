class AddToToken < ActiveRecord::Migration
  def change
    add_column :tokens, :token_type, :string
    remove_column :tokens, :type
  end
end
