class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  validates :order_products, length: { minimum: 1 }, on: :checkout

  validates :name, presence: true, on: :checkout

  validates :email, presence: true, on: :checkout

  validates :address1, presence: true, on: :checkout

  validates :city, presence: true, on: :checkout

  validates :state, presence: true, on: :checkout

  validates :zip, presence: true, on: :checkout

  validates :last_four_cc, presence: true, on: :checkout

  validates :expiration, presence: true, on: :checkout

  validates :cvv, presence: true, on: :checkout

  def checkout_amount
    sum = 0
    self.order_products.each do |op|
      sum += op.total_price
    end
    return sum
  end

  def last_four
    return self.last_four_cc.to_s[-4..-1]
  end
end
