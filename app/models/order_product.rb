class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }

  validate :availability

  def total_price
    total = self.product.price * self.quantity

    return format("$%.2f", total)
  end

  private

  def availability
    if product_id && quantity && (quantity > Product.find(product_id).quantity)
      errors.add(:quantity, "quantity is greater than amount in stock")
    end
  end
end
