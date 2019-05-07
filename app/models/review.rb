class Review < ApplicationRecord
  validates :text, presence: true
  validates :rating, presence: true

  belongs_to :product
end
