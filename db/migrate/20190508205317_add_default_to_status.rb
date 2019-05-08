class AddDefaultToStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :order_products, :status, "pending"
  end
end
