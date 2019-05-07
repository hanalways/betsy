require "test_helper"

describe Order do
  before do
    @order = orders(:one)
  end

  it "must be valid" do
    @order.save(context: :checkout)
    value(@order).must_be :valid?
  end

  it "won't be valid without data" do
    invalid_order = Order.new
    # invalid_order.save(context: :checkout)
    expect(invalid_order.valid?(:checkout)).must_equal false
  end

  describe "checkout_amount" do
    it "calculates the order total" do
      expect(@order.checkout_amount).must_equal 4.5
    end
  end

  describe "last_four" do
    it "gets the last four digits of the cc number" do
      expect(@order.last_four).must_equal "1111"
    end
  end
end
