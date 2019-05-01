class AddQuantityToOrderproduct < ActiveRecord::Migration[5.2]
  def change
    add_reference :order_products, :order, index: true
    add_reference :order_products, :product, index: true
    add_column :order_products, :quantity, :integer
  end
end
