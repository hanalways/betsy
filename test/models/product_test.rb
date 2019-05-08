require "test_helper"

describe Product do
  before do
    Product.create(
      name: "sample product",
      price: 100.0,
      quantity: 25,
      image_url: "http://www.fake.com/haksy.png",
      retired: false,
      description: "anything",
      merchant_id: merchants(:grace).id,
    )
  end

  let (:product) {
    Product.new(
      name: "new product",
      price: 100.0,
      quantity: 25,
      image_url: "http://www.fake.com/haksy.png",
      retired: false,
      description: "anything",
      merchant_id: merchants(:grace).id,
    )
  }
  describe "validations " do
    it "is valid when all requirements are met" do
      value(product).must_be :valid?
    end

    it "won't be valid if name is not present" do
      product.name = nil
      value(product).wont_be :valid?
    end

    it "won't be valid if name is not unique" do
      product.name = "sample product"
      value(product).wont_be :valid?
    end

    it "won't be valid if price is not present" do
      product.price = nil
      value(product).wont_be :valid?
    end

    it "won't be valid if price is not a number" do
      product.price = "not a number"
      value(product).wont_be :valid?
    end

    it "won't be valid if price is less than zero" do
      product.price = -3.50
      value(product).wont_be :valid?
    end
  end

  describe "relationships" do
    it "belongs to a merchant" do
      cat = products(:cat)
      expect(cat.merchant).must_equal merchants(:grace)
    end

    it "has many order products" do
      cat = products(:cat)
      expect(cat.order_products).must_include order_products(:op_two)
      expect(cat.order_products).must_include order_products(:op_three)
    end

    it "has many orders through order product" do
      cat = products(:cat)
      expect(cat.orders).must_include orders(:two)
      expect(cat.orders).must_include orders(:one)
    end

    it "has many categories" do
      cat = products(:cat)
      expect(cat.categories).must_include categories(:feline)
      expect(cat.categories).must_include categories(:mammal)
    end
  end
end
