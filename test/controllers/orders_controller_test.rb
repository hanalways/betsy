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
    end
  end
end
