require "test_helper"

describe MerchantsController do
  describe "index" do 
    it "can get the index page" do 
      get merchants_path 

      must_respond_with :success
    end
  end
end
