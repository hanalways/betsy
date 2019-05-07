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

  validate :email_must_be_valid, :cc_must_be_valid, :cvv_must_be_valid, :expiration_must_be_valid, on: :checkout

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

  private

  def email_must_be_valid
    unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      errors.add(:email, "must be a valid email")
    end
  end

  def cc_must_be_valid
    unless last_four_cc.to_s.length == 16
      errors.add("Credit card", "must have 16 digits")
    end
  end

  def cvv_must_be_valid
    unless cvv.to_s.length == 3 || cvv.to_s.length == 4
      errors.add("CVV", "must have 3 or 4 digits")
    end
  end

  def expiration_must_be_valid
    if expiration =~ /^(1[0-2]|0[1-9]|\d)\/([2-9]\d[1-9]\d|[1-9]\d)$/
      my_date = Date.strptime(expiration, "%m/%y")
      unless my_date > Date.today
        errors.add("Expiration", "cannot be in the past")
      end
    end
  end
end
