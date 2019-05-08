require "test_helper"

describe CategoriesController do
  describe "create" do
    let(:category_data) {
      {
        category: {
          name: "blah",
        },
      }
    }
    it "adds a category to the db" do
      expect {
        post categories_path, params: category_data
      }.must_change "Category.count", 1
    end
  end

  describe "index" do
    it "shows the page" do
      get categories_path
      must_respond_with :success
    end
  end

  describe "new" do
    it "shows the page" do
      get new_category_path
      must_respond_with :success
    end
  end
end
