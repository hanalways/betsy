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
      user = merchants(:ada)

      # Tell OmniAuth to use this data for the next request 
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Act
      expect {
        get auth_callback_path("github")
      }.wont_change "Merchant.count"

      # Assert
      expect(session[:user_id]).must_equal user.id
      # REMINDER: change this to root_path
      must_redirect_to merchants_path
    end

    it "creates an account for a new user and redirects to the root route" do
      user = Merchant.new(
        provider: "github", 
        uid: 200, 
        username: "New Merchant", 
        email: "new123@merchant.com"
      )

      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      expect {
        get auth_callback_path("github")
      }.must_change "Merchant.count", +1

      expect(session[:user_id]).must_equal Merchant.last.id
      must_redirect_to merchants_path
    end

    it "redirects to the login route if given invalid user data" do

    end
  end
end
