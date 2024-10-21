class CreateOrders < ActiveRecord::Migration[7.2]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true, null: false
      t.decimal :total_price, precision: 10, scale: 2, null: false
      t.integer :status, default: 0, null: false # pending: 0, confirmed: 1, shipped: 2

      t.timestamps
    end
  end
end
