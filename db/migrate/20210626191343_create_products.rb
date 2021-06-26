class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :description
      t.decimal :price
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
    add_index :products, :description, unique: true
  end
end
