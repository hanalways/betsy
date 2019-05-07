require "test_helper"

describe Review do
  let(:review) {
    Review.new(title: "My Review",
               rating: 4,
               text: "This is a review of the product",
               product_id: products(:dog).id)
  }

  describe "validations" do
    it "must be valid" do
      value(review).must_be :valid?
    end

    it "won't be valid if text is missing" do
      review.text = nil
      value(review).wont_be :valid?
    end

    it "won't be valid if rating is missing" do
      review.rating = nil
      value(review).wont_be :valid?
    end
  end

  describe "relationships" do
    it "belongs to a product" do
      expect(review.product).must_equal products(:dog)
    end
  end
end
