class Order < ApplicationRecord
  has_many :order_products
  has_many :products, through: :order_products

  validates :order_products, length: { minimum: 1 }, on: :checkout
end
