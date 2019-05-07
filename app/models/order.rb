class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  validates :order_products, length: { minimum: 1 }, on: :checkout

  def checkout_amount
    sum = 0
    self.order_products.each do |op|
      sum += op.total_price
    end
    return sum
  end
end
