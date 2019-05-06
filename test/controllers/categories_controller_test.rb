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
end
