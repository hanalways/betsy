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

    it "adds to the existing op's quantity if that item already exists in the cart" do
      post order_products_path(order_product_data)

      expect {
        post order_products_path(order_product_data)
      }.wont_change "OrderProduct.count"
    end
  end

  describe "update" do
    let(:order_product_data) {
      {
        order_product: {
          product_id: Product.first.id,
          order_id: Order.first.id,
          quantity: 3,
          status: "shipped"
        },
      }
    }

    let(:order_product_second) {
      {
        order_product: {
          product_id: Product.last.id,
          order_id: Order.last.id,
          quantity: 4,
          status: "pending"
        }
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

  describe "update status" do 
    it "changes status from shipped to pending" do 
      op = OrderProduct.first
      patch update_status_path(op.id)
      op.reload
      
      expect(op.status).must_equal "pending"
    end

    it "changes status from pending to shipped" do 
      op = OrderProduct.last
      op.status = "pending"

      patch update_status_path(op.id)
      op.reload
      
      expect(op.status).must_equal "shipped"
    end
  end
end
