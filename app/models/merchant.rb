class Merchant < ApplicationRecord
  has_many :products

  def self.build_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash[:uid]
    merchant.provider = "github"
    merchant.username = auth_hash["info"]["username"]
    merchant.email = auth_hash["info"]["email"]

    return merchant 
  end
end