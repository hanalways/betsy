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
end
