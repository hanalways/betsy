class OrderProductsController < ApplicationController
  before_action :find_order_product, only: [:destroy, :update]

  def create
    @order_product = OrderProduct.new(order_product_params)

    if @order_product.save
      flash[:status] = :success
      flash[:message] = "Successfully added product to order"
      redirect_back(fallback_location: root_path)
    else
      flash[:status] = :error
      flash[:message] = "Could not add product to order"
      flash[:errors] = @order_product.errors
      redirect_back(fallback_location: root_path)
    end
  end

  def update
    if @order_product.update(order_product_params)
      flash[:status] = :success
      flash[:message] = "Sucessfully updated quantity"
      redirect_back(fallback_location: root_path)
    else
      flash[:status] = :error
      flash[:message] = "Failed to update quantity"
      flash[:errors] = @product.errors.messages
      redirect_back(fallback_location: root_path)
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
      flash[:errors] = @order_product.errors
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def order_product_params
    params.require(:order_product).permit(:quantity, :product_id, :order_id)
  end

  def find_order_product
    @order_product = OrderProduct.find_by(id: params[:id])
  end
end
