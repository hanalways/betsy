class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products
  belongs_to :merchant
  has_and_belongs_to_many :categories
end
