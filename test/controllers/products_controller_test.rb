require "test_helper"

describe ProductsController do
  it "loads the index page" do
    get products_path
    must_respond_with :success
  end
end
