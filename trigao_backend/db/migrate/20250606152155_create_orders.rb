class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :order_date, null: false
      t.decimal :total_amount, precision: 10, scale: 2
      t.string :payment_type, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
    
    add_index :orders, :status
  end
end
