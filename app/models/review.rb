class Review < ApplicationRecord
  validates :text, presence: true
  validates :rating, presence: true
  validates :rating, numericality: { only_integer: true }
  validates :rating, numericality: { less_than: 6 }
  validates :rating, numericality: { greater_than: 0 }
  belongs_to :product
end
