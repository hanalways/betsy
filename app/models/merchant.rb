class Merchant < ApplicationRecord
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.build_from_github(auth_hash)
    # binding.pry
    merchant = Merchant.new
    merchant.uid = auth_hash[:uid]
    merchant.image_url = auth_hash["extra"]["raw_info"]["avatar_url"]
    merchant.provider = "github"
    merchant.username = auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]

    return merchant
  end
end
