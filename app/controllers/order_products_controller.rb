class OrderProductsController < ApplicationController
  before_action :find_order_product, only: [:destroy]

  def create
    @order_product = OrderProduct.new(order_product_params)
    if @order_product.save
      flash[:status] = :success
      flash[:message] = "Successfully added product to order"
      redirect_to root_path
    else
      flash[:status] = :warning
      flash[:message] = "Could not add product to order"
    end
  end

  def destroy
    if @order_product.destroy
      flash[:status] = :success
      flash[:message] = "sucessfully removed product from order"
      redirect_back(fallback_location: root_path)
    else
      flash[:status] = :error
      flash[:message] = "Failed to remove product from order"
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_product_params
    params.require(:order_product).permit(:quantity, :order_id, :product_id)
  end

  def find_order_product
    @order_product = OrderProduct.find_by(id: params[:id])
  end
end
