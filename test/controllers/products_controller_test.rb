require "test_helper"

describe ProductsController do
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

  describe "Logged in merchants" do
    before do
      perform_login(merchants(:grace))
    end

    describe "all access for merchants" do
      it "can access homepage" do
        get root_path
        must_respond_with :success
      end

      it "can access new product page" do 
        get new_product_path 
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

          check_flash
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
          check_flash
          must_redirect_to product_path(product.id)
        end

        it "will return a 404 if given an invalid id" do
          product_hash[:id] = -1
          patch merchant_product_path(merchant_id: session[:user_id], id: product_hash[:id]), params: product_hash
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
    let(:products) {
      Product.all
    }

    describe "access for guest users" do
      it "can access the homepage" do
        get root_path
        must_respond_with :success
      end

      it "can access the products index page" do
        get products_path
        must_respond_with :success
      end

      it "cannot access new product page" do 
        get new_product_path 
        must_respond_with :redirect
      end

      it "cannot access invalid product show page" do
        get product_path(Product.last.id + 1)

        must_respond_with :not_found
      end

      it "cannot access the new product form" do
        get new_product_path
        must_redirect_to root_path
        check_flash(:error)
      end
    end
  end

  describe "ownership" do
    before do
      perform_login(merchants(:grace))
    end
    let (:product_hash) {
      {
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
    it "logged in user can't view edit page for product that isn't theirs" do
      get edit_merchant_product_path(merchant_id: session[:user_id], id: products(:dog).id)
      check_flash(:error)
      must_respond_with :redirect
    end

    it "logged in user can't update product that isn't theirs" do
      patch merchant_product_path(merchant_id: session[:user_id], id: products(:dog).id), params: product_hash
      check_flash(:error)
      must_respond_with :redirect
    end

    it "logged in user can't retire product that isn't theirs" do
      post toggle_retire_product_path(products(:dog).id)
      check_flash(:error)
      must_respond_with :redirect
    end
  end
end
