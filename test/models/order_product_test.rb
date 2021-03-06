require "test_helper"

describe OrderProduct do
  describe "validations" do
    before do
      @order_product = order_products(:op_one)
    end

    it "must be valid" do
      value(@order_product).must_be :valid?
    end

    it "must be invalid without data" do
      invalid_op = OrderProduct.new
      value(invalid_op).wont_be :valid?
    end

    it "must be invalid with quantity of zero" do
      less_than_zero = OrderProduct.new(product: Product.first, order: Order.first, quantity: 0)
      value(less_than_zero).wont_be :valid?
    end
  end
  describe "total_price" do
    before do
      @order_product = order_products(:op_one)
    end

    it "calculates the total price per item" do
      expect(@order_product.total_price).must_equal 4.5
    end
  end

  describe "availability" do
    before do
      @order_product = order_products(:op_one)
    end

    it "is invalid if not available" do
      @order_product.quantity = 2500
      value(@order_product).wont_be :valid?
    end

    it "is valid if available" do
      @order_product.quantity = 1
      value(@order_product).must_be :valid?
    end
  end
end
