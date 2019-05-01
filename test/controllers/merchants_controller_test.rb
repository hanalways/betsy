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
      
      # Create mock data for this user as though it hasd come from github
      # mock_auth_hash = {
        #   uid: user.uid,
        #   provider: user.provider,
        #   info: {
          #     name: user.username,
          #     email: user.email,
          #   }
          # }
          
      user = merchants(:ada)

      # Tell OmniAuth to use this data for the next request 
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(mock_auth_hash(user))

      # Act
      expect {
        get auth_callback_path("github")
      }.wont_change "Merchant.count"

      # Assert
      expect(session[:user_id]).must_equal user.id
      must_redirect_to merchants_path
    end

    it "creates an account for a new user and redirects to the root route" do

    end

    it "redirects to the login route if given invalid user data" do

    end
  end
end
