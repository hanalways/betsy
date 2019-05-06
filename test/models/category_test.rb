require "test_helper"

describe Category do
  let(:category) {
    Category.create(name: "new")
  }

  it "must be valid with name" do
    value(category).must_be :valid?
  end

  it "won't be valid without name" do
    category_invalid = Category.new
    value(category_invalid).wont_be :valid?
  end

  it "has products" do
    category = categories(:red)
    expect(category.products.count).must_equal 2
  end
end
