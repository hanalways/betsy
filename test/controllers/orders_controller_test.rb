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
          last_four_cc: 9999,
          expiration: "7/09",
        },
      }
    }
    it "adds a record to the db" do
      expect {
        post orders_path(order_data)
      }.must_change "Order.count", 1

      must_redirect_to root_path
    end
  end

  describe "show" do
    it "loads the page" do
      get order_path(Order.first.id)
      must_respond_with :success
    end

    it "404 with invalid order id" do
      get order_path(Order.last.id + 1)
      must_respond_with :not_found
    end
  end

  describe "edit" do
    it "shows the page" do
      get edit_order_path(Order.first.id)
      must_respond_with :success
    end

    it "404 if order is invalid" do
      get edit_order_path(Order.last.id + 1)
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
      expect {
        delete order_path(Order.first)
      }.must_change "Order.count", -1
      check_flash
    end
  end
end
