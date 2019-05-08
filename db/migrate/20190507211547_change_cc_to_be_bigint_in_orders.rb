class ChangeCcToBeBigintInOrders < ActiveRecord::Migration[5.2]
  def change
    change_column :orders, :last_four_cc, :bigint
  end
end
