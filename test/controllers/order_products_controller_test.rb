require "test_helper"

describe OrderProductsController do
  before do
    @order_product = order_products(:op_one)
  end
  describe "create" do
    let(:order_product_data) {
      {
        order_product: {
          product_id: Product.first.id,
          order_id: Order.first.id,
          quantity: 3,
        },
      }
    }
    it "adds an order_product to the db" do
      op = OrderProduct.new
      expect {
        post order_products_path(order_product_data)
      }.must_change "OrderProduct.count", 1
      check_flash
    end
  end

  describe "update" do
    let(:order_product_data) {
      {
        order_product: {
          product_id: Product.first.id,
          order_id: Order.first.id,
          quantity: 3,
        },
      }
    }
    it "changes the data in the db" do
      patch order_product_path(OrderProduct.first), params: order_product_data

      op = OrderProduct.first
      expect(op.quantity).must_equal 3

      check_flash
    end
  end

  describe "destroy" do
    it "removes an order_product from the db" do
      expect {
        delete order_product_path(OrderProduct.first)
      }.must_change "OrderProduct.count", -1
      check_flash
    end
  end
end
