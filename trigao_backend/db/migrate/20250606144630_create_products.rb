class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.references :category, null: false, foreign_key: true
      t.decimal :price
      t.string :unit
      t.integer :stock_level, default: 0
      t.integer :status, default: 0
      t.string :tax_info

      t.timestamps
    end
    add_index :products, :code, unique: true
    add_index :products, :status
  end
end
