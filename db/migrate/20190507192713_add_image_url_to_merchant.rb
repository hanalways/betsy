class AddImageUrlToMerchant < ActiveRecord::Migration[5.2]
  def change
    add_column :merchants, :image_url, :string
  end
end
