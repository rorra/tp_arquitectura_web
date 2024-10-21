class CreateProducts < ActiveRecord::Migration[7.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :description
      t.decimal :price, precision: 10, scale: 2, null: false
      t.integer :stock, null: false, default: 0
      t.references :category, foreign_key: true, null: false

      t.timestamps
    end
    add_index :products, :name, unique: true
  end
end
