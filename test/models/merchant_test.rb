require "test_helper"

describe Merchant do
  before do
    @ada = merchants(:ada)
    @grace = merchants(:grace)
  end

  it "must be valid" do
    Merchant.all.each do |merchant|
      expect(merchant.valid?).must_equal true
    end
  end

  describe "merchant model relationship" do
    it "has a relationship to products" do
      expect(@ada.products.first.name).must_equal "dog"
      expect(@ada.id).must_equal @ada.products.first.merchant_id
      expect(@grace.products.first.name).must_equal "cat"
      expect(@grace.id).must_equal @grace.products.first.merchant_id
    end

    it "has many products" do
      dog = products(:dog)

      @ada.must_respond_to :products

      @ada.products.each do |product|
        product.must_be_kind_of Product
      end
    end
  end

  describe "merchant model validation" do
    it "requires a name and email" do
      merchant = Merchant.new(uid: 20, provider: "github")
      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :username
      merchant.errors.messages.must_include :email
    end

    it "requires a unique name" do
      merchant = Merchant.new(username: @ada.username, email: "testemail@testemail.com")

      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :username
    end

    it "requires a unique email" do
      merchant = Merchant.new(username: "test name", email: @grace.email)

      merchant.valid?.must_equal false
      merchant.errors.messages.must_include :email
    end

    it "requires email to be of a valid format" do 
      merchant = Merchant.new(username: @ada.username, email: "not an email")
      merchant.valid?.must_equal false 
      merchant.errors.messages.must_include :email
      
      merchant1 = Merchant.new(username: @ada.username, email: "notanemail")
      merchant.valid?.must_equal false 
      merchant.errors.messages.must_include :email

      merchant2 = Merchant.new(username: @ada.username, email: "notanemail@")
      merchant.valid?.must_equal false 
      merchant.errors.messages.must_include :email

      merchant3 = Merchant.new(username: @ada.username, email: "notanemail@nonemail")
      merchant.valid?.must_equal false 
      merchant.errors.messages.must_include :email

      merchant4 = Merchant.new(username: @ada.username, email: "notanemail@nonemail.")
      merchant.valid?.must_equal false 
      merchant.errors.messages.must_include :email
    end

    it "allows new merchant when name and email are unique" do
      valid_merchant = Merchant.new(username: "unique name", email: "unique@email.com")

      valid_merchant.valid?.must_equal true
    end
  end

  describe "build from github" do
    let(:auth_hash) {
      auth_hash = {
        uid: 20,
        "info" => {
          "nickname" => "test nickname",
          "email" => "testemail@email.com",
        },
      }
    }

    it "returns a valid merchant from auth_hash" do
      merchant = Merchant.build_from_github(auth_hash)

      merchant.valid?.must_equal true
    end

    it "returns invalid if auth_hash username is missing" do
      auth_hash["info"]["nickname"] = nil

      merchant = Merchant.build_from_github(auth_hash)
      merchant.valid?.must_equal false
    end

    it "returns invalid if auth_hash email is missing" do
      auth_hash["info"]["email"] = nil

      merchant = Merchant.build_from_github(auth_hash)
      merchant.valid?.must_equal false
    end
  end

  describe "custom methods" do
    before do 
      @op1 = order_products(:op_one)
      @op2 = order_products(:op_two)
      @dog = products(:dog)
      @cat = products(:cat)
    end 

    describe "orders of status" do 
      it "returns orders of status :pending" do 
        order_array = @ada.orders_of_status(:pending)
        order_array.each do |op|
          op.must_be_instance_of OrderProduct
          op.status.must_equal "pending"
        end
      end

      it "returns orders of status :shipped" do 
        order_array = @grace.orders_of_status(:shipped)
        order_array.each do |op|
          op.must_be_instance_of OrderProduct 
          op.status.must_equal "shipped"
        end
      end
    end

    describe "revenue of status" do 
      it "counts the total price of :pending orders" do 
        pending_revenue = @ada.revenue_of_status(:pending)
        pending_revenue.must_equal (1.50 * 3)
      end

      it "counts the total price of :shipped orders" do 
        shipped_revenue = @grace.revenue_of_status(:shipped)
        shipped_revenue.must_equal (11.50 * 5)
      end
    end

    describe "order count" do 
      it "returns the correct count of :pending orders" do
        pending_orders = @grace.order_count(:pending)
        pending_orders.must_equal 1
      end

      it "returns the correct count of :shipped orders" do 
        shipped_orders = @ada.order_count(:shipped)
        shipped_orders.must_equal 0
      end
    end

    describe "total revenue" do 
      it "returns the correct amount of total revenue" do 
        total_revenue = @ada.total_revenue
        total_revenue.must_equal (1.50 * 3)
      end
    end
  end
end
