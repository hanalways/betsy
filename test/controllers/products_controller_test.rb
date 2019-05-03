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
      merchant_id: merchants(:grace).id,
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
        merchant_id: merchant.id,
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

  describe "show" do
    it "can get a valid product" do
      get product_path(product.id)
      must_respond_with :success
    end

    it "will redirect for an invalid product" do
      get product_path(-1)
      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new product" do
      post products_path, params: product_hash

      new_product = Product.find_by(merchant_id: product_hash[:product][:merchant_id])
      expect(new_product.name).must_equal product_hash[:product][:username]

      must_respond_with :redirect
      must_redirect_to product_path(new_product.id)
    end
  end

  describe "edit" do
    it "can get the edit page for an existing product" do
      get edit_product_path(product.id)
      must_respond_with :success
    end

    it "will respond with 404 when attempting to edit a nonexistant product" do
      get edit_product_path(-1)
      must_respond_with :not_found
    end
  end

  describe "update" do
    it "can update an existing product" do
      product_hash[:product][:name] = "updated product"
      patch product_path(product.id), params: product_hash
      must_respond_with :redirect
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
      expect {
        delete product_path(Product.first.id)
      }.must_change "Product.count", -1
      must_respond_with :success
    end

    it "will redirect to the root page if given an invalid id" do
      delete product_path(-1)
      must_respond_with :not_found
    end
  end

  describe "toggle_retire" do
    it "will retire an unretired product" do
      post toggle_retire_product_path(product.id)
      product.reload
      expect(product.retired).must_equal true
    end

    it "will unretire a retired product" do
      product.retired = true
      product.save
      product.reload
      post toggle_retire_product_path(product.id)
      product.reload
      expect(product.retired).must_equal false
    end
  end

  describe "Logged in merchants" do 
    before do 
      perform_login(merchants(:grace))
    end

    describe "all access for merchants" do 
      it "can access homepage" do 
        get root_path 
        must_respond_with :success 
      end

      it "can access all products index page" do 
        products = Product.all
        get products_path 
        must_respond_with :success 
      end

      it "can access the show page for each product" do 
        product_id = Product.first.id 
        get product_path(product_id)
        must_respond_with :success
      end

      it "cannot access the show page for a product that doesn't exist" do 
        product_id = Product.last.id + 1

        get product_path(product_id)
        must_respond_with :not_found
      end

      it "can access the new product form" do 
        perform_login(merchants(:grace))
        get new_product_path
        must_respond_with :success
      end
    end

    describe "update for logged in merchants" do 
      it "can create product with valid data" do 
        product_data = {
          product: {
            name: "test product",
            price: 50.75,
            quantity: 1,
            image_url: "http://placekitten.com/150/150",
            description: "test desc",
            merchant_id: 1,
            retired: false,
          }
        }

        expect {
          post products_path, params: product_data 
        }.must_change "Product.count", +1
      end

      it "won't create a new product given incomplete data" do 
        product_data = {
          
        }
    end
  end

  describe "Guest users" do 

  end
end
