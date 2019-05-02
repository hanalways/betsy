require "test_helper"

describe MerchantsController do
  describe "index" do 
    it "can get the index page" do
      get merchants_path

      must_respond_with :success
    end
  end

  describe "show" do 
    it "can get the show page" do 
      merchant = merchants(:ada)
      get merchant_path(merchant)

      must_respond_with :success
    end 
  end 

  describe "auth callback" do 
    it "can log in an existing user" do
      start_count = Merchant.count   
      merchant = merchants(:ada)

      perform_login(merchant)
      must_redirect_to root_path
      session[:user_id].must_equal merchant.id 

      Merchant.count.must_equal start_count
    end

    it "creates an account for a new user and redirects to the root route" do
      start_count = Merchant.count
      merchant = Merchant.new(
        provider: "github", 
        uid: 200, 
        username: "New Merchant", 
        email: "new123@merchant.com"
      )

      # binding.pry

      perform_login(merchant)
      must_redirect_to root_path

      # Not working, why?
      Merchant.count.must_equal start_count + 1

      session[:user_id].must_equal Merchant.last.id
    end

    it "redirects to the login route if given invalid user data" do
      invalid_merchant = Merchant.new(
        username: nil,
        email: nil,
      )

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(invalid_merchant))
      
      expect {
        get auth_callback_path("github")
      }.wont_change "Merchant.count"
    end
  end
end
