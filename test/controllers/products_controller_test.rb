require "test_helper"

describe ProductsController do
  let(:merchant) {
    Merchant.create(
      username: "reliant merchant for product",
      email: "merchant@yahoo.com",
      uid: 1,
      provider: "me",
    )
  }

  let (:product) {
    Product.create(
      name: "sample product",
      price: 100.0,
      quantity: 25,
      image_url: "http://www.fake.com/haksy.png",
      retired: false,
      description: "anything",
      merchant_id: merchant.id,
    )
  }

  let (:product_hash) {
    {
      id: product.id,
      product: {
        name: "another sample product",
        price: 200.0,
        quantity: 50,
        image_url: "http://www.fake.com/haksy2.png",
        retired: true,
        description: "everything",
        merchant_id: 2,
      },
    }
  }

  describe "index" do
    it "can get the index path" do
      get products_path
      must_respond_with :success
    end

    it "can get the root path" do
      get root_path
      must_respond_with :success
    end
  end

  # describe "show" do
  #   it "can get a valid product" do
  #     get product_path(product.id)
  #     must_respond_with :success
  #   end

  #   it "will redirect for an invalid product" do
  #     get product_path(-1)
  #     must_respond_with :redirect
  #     expect(flash[:error]).must_equal "Could not find product with id: -1"
  #   end
  # end

  describe "create" do
    it "can create a new product" do
      post products_path, params: product_hash

      new_product = Product.find_by(merchant_id: product_hash[:product][:merchant_id])
      expect(new_product.name).must_equal product_hash[:product][:name]

      # must_respond_with :redirect
      # must_redirect_to products_path
      # Where should we direct this?
    end
  end

  # no edit method yet
  # describe "edit" do
  #   it "can get the edit page for an existing product" do
  #     get edit_product_path(product.id)
  #     must_respond_with :success
  #   end

  #   it "will respond with redirect when attempting to edit a nonexistant product" do
  #     get edit_product_path(-1)
  #     must_respond_with :redirect
  #     expect(flash[:error]).must_equal "Could not find product with id: -1"
  #   end
  # end

  describe "update" do
    it "can update an existing product" do
    end

    it "will redirect to the root page if given an invalid id" do
      product_hash[:id] = -1
      patch product_path(product_hash[:id]), params: product_hash
      must_respond_with :not_found
    end

    it "will throw a error if there is an invalid product name" do
      product_hash[:name] = "bad product"
      assert_raise(Exception) { patch product_path, params: product_hash }
    end
  end

  describe "destroy" do
    it "deletes the product from the database" do
    end

    # it "will redirect to the root page if given an invalid id" do
    #   delete delete_product_path(-1)
    #   must_respond_with :redirect
    #   expect(flash[:error]).must_equal "Could not find product with id: -1"
    # end
  end
end
