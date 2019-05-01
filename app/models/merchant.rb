class Merchant < ApplicationRecord
  def self.build_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash[:uid]
    user.provider = "github"
    user.username = auth_hash["info"]["username"]
    user.email = auth_hash["info"]["email"]

    return user 
  end
end