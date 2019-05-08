class AddCvvToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :cvv, :integer
  end
end
