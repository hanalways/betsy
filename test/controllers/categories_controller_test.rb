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

  describe "create" do
    let(:category_params) {
      {
        category: {
          name: "New category",
        },
      }
    }
    it "allows a logged in user to create a category" do
      perform_login(merchants(:grace))
      expect {
        post categories_path, params: category_params
      }.must_change "Category.count", +1
    end

    it "will flash errors if category fails to save" do
      perform_login(merchants(:grace))
      post categories_path, params: category_params
      # try to make another with the same name
      post categories_path, params: category_params
      check_flash(:error)
    end
  end
end
