require "test_helper"

describe ReviewsController do
  describe "create" do
    before do
      @review_params = {
        "review" => {
          title: "My Review",
          rating: 4,
          text: "This is a review of the product",
        },
      }
    end

    it "allows a guest user to create a review" do
      expect {
        post product_reviews_path(product_id: products(:dog)), params: @review_params
      }.must_change "Review.count", +1

      expect(flash[:status]).must_equal :success
      must_redirect_to product_path(products(:dog).id)
    end

    it "allows a logged in user to review a product that isn't their own" do
      perform_login(merchants(:grace))

      expect {
        post product_reviews_path(product_id: products(:dog)), params: @review_params
      }.must_change "Review.count", +1

      expect(flash[:status]).must_equal :success
      must_redirect_to product_path(products(:dog).id)
    end

    it "does not allow a logged in user to review their own product" do
      perform_login(merchants(:ada))

      expect {
        post product_reviews_path(product_id: products(:dog)), params: @review_params
      }.wont_change "Review.count"

      expect(flash[:status]).must_equal :error
      must_redirect_to product_path(products(:dog).id)
    end

    it "fails to create a review for product that doesn't exist" do
      post product_reviews_path(product_id: -1), params: @review_params

      must_respond_with :not_found
    end

    it "redirects and displays an error if the review fails to save" do
      @review_params["review"][:text] = nil
      post product_reviews_path(products(:dog).id), params: @review_params

      expect(flash[:status]).must_equal :error
      must_respond_with :redirect
    end
  end
end
