class Merchant < ApplicationRecord
  has_many :products

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  def self.build_from_github(auth_hash)
    merchant = Merchant.new
    merchant.uid = auth_hash[:uid]
    merchant.image_url = auth_hash["extra"]["raw_info"]["avatar_url"] if auth_hash["extra"]
    merchant.provider = "github"
    merchant.username = auth_hash["info"]["nickname"]
    merchant.email = auth_hash["info"]["email"]

    return merchant
  end

  def orders_of_status(status)
    OrderProduct.where(status: status).joins(:product).merge(Product.where(merchant_id: id))
  end

  def revenue_of_status(status)
    ops = orders_of_status(status)
    sum = 0
    ops.each do |order|
      sum += order.total_price
    end
    return sum 
  end

  def order_count(status)
    ops = orders_of_status(status)
    return ops.count
  end

  def total_revenue
    return orders_of_status()
  end

end
