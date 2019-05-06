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
        merchant_id: merchants(:grace).id,
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
        get merchant_product_path(merchant_id: session[:user_id], id: product_id)
        must_respond_with :success
      end

      it "cannot access the show page for a product that doesn't exist" do
        product_id = Product.last.id + 1

        get merchant_product_path(merchant_id: session[:user_id], id: product_id)
        must_respond_with :not_found
      end

      describe "create" do
        it "can create a new product" do
          post merchant_products_path(merchant_id: session[:user_id]), params: product_hash

          new_product = Product.find_by(name: product_hash[:product][:name])
          expect(new_product.merchant_id).must_equal product_hash[:product][:merchant_id]
          expect(new_product.description).must_equal product_hash[:product][:description]
          expect(new_product.price).must_equal product_hash[:product][:price]
          expect(new_product.quantity).must_equal product_hash[:product][:quantity]
          expect(new_product.retired).must_equal product_hash[:product][:retired]
          expect(new_product.image_url).must_equal product_hash[:product][:image_url]

          must_respond_with :redirect
          must_redirect_to product_path(new_product.id)
        end
      end

      describe "edit" do
        it "can get the edit page for an existing product" do
          get edit_merchant_product_path(merchant_id: session[:user_id], id: product.id)
          must_respond_with :success
        end

        it "will respond with 404 when attempting to edit a nonexistant product" do
          get edit_merchant_product_path(merchant_id: session[:user_id], id: -1)
          must_respond_with :not_found
        end
      end

      describe "update" do
        it "can update an existing product" do
          product_hash[:product][:name] = "updated product"
          patch merchant_product_path(merchant_id: session[:user_id], id: product.id), params: product_hash
          must_respond_with :redirect
        end

        it "will redirect to the root page if given an invalid id" do
          product_hash[:id] = -1
          patch merchant_product_path(merchant_id: session[:user_id], id: product_hash[:id]), params: product_hash
          must_respond_with :not_found
        end
      end

      describe "destroy" do
        it "deletes the product from the database" do
          test_id = product.id
          expect {
            delete merchant_product_path(merchant_id: session[:user_id], id: product.id)
          }.must_change "Product.count", -1
          must_respond_with :success

          expect Product.find_by(id: test_id).must_be_nil
        end

        it "will redirect to the root page if given an invalid id" do
          delete merchant_product_path(merchant_id: session[:user_id], id: -1)
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
    end
  end

  describe "Guest users" do
  end
end
