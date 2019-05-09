require "test_helper"

describe OrdersController do
  describe "create" do
    let(:order_data) {
      {
        order: {
          address1: "4 Main St",
          city: "Rolf",
          state: "WA",
          zip: 90000,
          email: "ho@ho.com",
          last_four_cc: 9999111122229999,
          expiration: "07/29",
          cvv: 676,
        },
      }
    }
    it "adds a record to the db" do
      # every test adds an extra Order to the db because of the set_cart controller filter in ApplicationController
      expect {
        post orders_path(order_data)
      }.must_change "Order.count", 2

      must_redirect_to root_path
    end
  end

  describe "show" do
    describe "logged-in merchant" do
      before do
        perform_login(merchants(:grace))
      end
      it "loads the page" do
        get order_path(id: Order.first.id)
        must_respond_with :success
      end

      it "404 with invalid order id" do
        get order_path(id: Order.last.id + 1)
        must_respond_with :not_found
      end
    end
  end

  describe "edit" do
    it "shows the page" do
      op = OrderProduct.first
      order = op.order
      get edit_order_path(order)
      must_respond_with :success
    end

    it "404 if order is invalid" do
      get edit_order_path(Order.last.id + 100)
      must_respond_with :not_found
    end
  end

  describe "update" do
    let(:order_data) {
      {
        order: {
          address1: "4 Main St",
          city: "Rolf",
          state: "WA",
          zip: 90000,
          email: "ho@ho.com",
          last_four_cc: 9999,
          expiration: "7/09",
        },
      }
    }
    it "updates the order" do
      patch order_path(Order.first), params: order_data

      order = Order.first
      expect(order.zip).must_equal 90000
      must_redirect_to order_path(Order.first)
      check_flash
    end
  end

  describe "destroy" do
    it "removes the order from the db" do
      old_number = Order.count
      delete order_path(Order.first)
      # every test adds an extra Order to the db because of the set_cart controller filter in ApplicationController
      expect(Order.count).must_equal old_number
      check_flash
    end
  end

  describe "cart" do
    before do
      @order = Order.first
      @order.status = "pending"
      @order.save
    end
    describe "current" do
      it "loads the page" do
        get current_order_path(@order)
        must_respond_with :success
      end
    end

    describe "checkout" do
      let(:order_params) {
        {
          order: {
            name: "K",
            email: "giraffe@owl.com",
            address1: "65 Main st",
            city: "durham",
            state: "MA",
            zip: 98100,
            last_four_cc: 7777888888886666,
            expiration: "12/25",
            cvv: 344,
          },
        }
      }
      before do
        # accessing the site will call the private controller filter set_cart
        get root_path
        # add something to cart
        @op = OrderProduct.create!(
          order_id: session[:order_id],
          product_id: products(:dog).id,
          quantity: 4,
        )
        @order = Order.find(session[:order_id])
      end
      it "updates the order status" do
        post checkout_path, params: order_params
        @order.reload
        expect(@order.status).must_equal "paid"

        must_redirect_to order_confirmation_path(@order)
      end

      it "won't check out if order_product quantity is higher than in-stock quantity" do
        product = Product.find_by(id: @op.product_id)
        product.quantity = 1
        product.save
        post checkout_path, params: order_params
        check_flash(:error)
      end

      it "won't check out if order is invalid" do
        @op.destroy
        post checkout_path, params: order_params
        check_flash(:error)
      end
    end
  end
end
