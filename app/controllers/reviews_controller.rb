class ReviewsController < ApplicationController
  def create
    unless Product.find_by(id: params[:product_id])
      head :not_found
      return
    end

    if session[:user_id] == Product.find(params[:product_id]).merchant_id
      flash[:status] = :error
      flash[:message] = "Merchants can't review their own products!"
      redirect_to product_path(params[:product_id])
      return
    end

    @review = Review.new review_params
    @review.product_id = params[:product_id]

    if @review.save
      flash[:status] = :success
      flash[:message] = "You sucessfully reviewed #{Product.find(params[:product_id]).name}"
      redirect_to product_path(params[:product_id])
    else
      flash[:status] = :error
      flash[:message] = "Failed to add your review"
      flash[:errors] = @review.errors.messages
      redirect_back fallback_location: root_path
    end
  end

  private

  def review_params
    return params.require(:review).permit(
             :rating,
             :title,
             :text,
           )
  end
end
