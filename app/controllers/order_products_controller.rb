class OrderProductsController < ApplicationController
  before_action :find_order_product, only: [:destroy, :update]

  def create
    @order_product = OrderProduct.find_by(order_id: order_product_params[:order_id], product_id: order_product_params[:product_id])
    if @order_product
      @order_product.quantity += order_product_params[:quantity].to_i
    else
      @order_product = OrderProduct.new(order_product_params)
    end

    if @order_product.save
      flash[:status] = :success
      flash[:message] = "Successfully added product to order"
      redirect_back(fallback_location: root_path)
    else
      flash_error("Could not add product to order")
    end
  end

  def update
    if @order_product.update(order_product_params)
      flash[:status] = :success
      flash[:message] = "Sucessfully updated quantity"
      redirect_back(fallback_location: root_path)
    else
      flash_error("Failed to update quantity")
    end
  end

  def destroy
    if @order_product.destroy
      flash[:status] = :success
      flash[:message] = "Successfully removed product from order"
      redirect_back(fallback_location: root_path)
    else
      flash_error("Failed to remove product from order")
    end
  end

  def update_status
    @order_product = OrderProduct.find_by(id: params[:id])
    if @order_product.status == "shipped"
      @order_product.status = :pending
    else @order_product.status == "pending"
      @order_product.status = :shipped     end

    if @order_product.save
      flash[:status] = :success
      flash[:message] = "Order \##{@op.id} status updated."
      redirect_to dashboard_path
    else
      flash_error("Failed to update Order \##{@op.id}")
    end
  end

  private

  def order_product_params
    params.require(:order_product).permit(:quantity, :product_id, :order_id, :status)
  end

  def find_order_product
    @order_product = OrderProduct.find_by(id: params[:id])
  end

  def flash_error(message)
    flash[:status] = :error
    flash[:message] = message
    flash[:errors] = @order_product.errors.messages
    redirect_back(fallback_location: root_path)
  end
end
