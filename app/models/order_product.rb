class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
end
