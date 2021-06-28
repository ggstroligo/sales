class RemoveAndAddIndexesToProduct < ActiveRecord::Migration[6.0]
  def change
    remove_index :products, [:description]
    add_index :products, [:description, :price, :merchant_id], unique: true
  end
end
