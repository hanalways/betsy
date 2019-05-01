class AddUidAndProviderToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :uid, :integer
    add_column :merchants, :provider, :string
  end
end
