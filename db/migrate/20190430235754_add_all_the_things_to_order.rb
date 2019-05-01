class AddAllTheThingsToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :status, :string
    add_column :orders, :email, :string
    add_column :orders, :address1, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip, :integer
    add_column :orders, :last_four_cc, :integer
    add_column :orders, :expiration, :string
  end
end
