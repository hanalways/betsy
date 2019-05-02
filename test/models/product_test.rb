require "test_helper"

describe Product do
  let (:product) {
    Product.create(
      name: "sample product",
      price: 100.0,
      quantity: 25,
      image_url: "http://www.fake.com/haksy.png",
      retired: false,
      description: "anything",
      merchant_id: merchants(:two).id,
    )
  }

  it "must be valid" do
    value(product).must_be :valid?
  end
end
