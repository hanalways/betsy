class AddTotalToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :total_price, :float
  end
end
