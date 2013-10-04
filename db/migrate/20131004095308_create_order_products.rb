class CreateOrderProducts < ActiveRecord::Migration
  def change
    create_table :order_products do |t|
      t.string :order_id
      t.string :product_id
      t.integer :price_in_pence
      t.integer :quantity

      t.timestamps
    end
  end
end
