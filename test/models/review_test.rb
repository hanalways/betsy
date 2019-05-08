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

    it "won't be valid if rating is not a number" do
      review.rating = "fish"
      value(review).wont_be :valid?
    end

    it "won't be valid if rating is not an integer" do
      review.rating = 1.7777
      value(review).wont_be :valid?
    end

    it "won't be valid if rating is less than 1" do
      review.rating = 0
      value(review).wont_be :valid?
    end

    it "won't be valid if rating is greater than 5" do
      review.rating = 6
      value(review).wont_be :valid?
    end
  end

  describe "relationships" do
    it "belongs to a product" do
      expect(review.product).must_equal products(:dog)
    end
  end
end
