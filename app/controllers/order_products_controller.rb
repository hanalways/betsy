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
      flash[:message] = "Successfully removed product from order"
      redirect_back(fallback_location: root_path)
    else
      flash[:status] = :error
      flash[:message] = "Failed to remove product from order"
      flash[:errors] = @order_product.errors
      redirect_back(fallback_location: root_path)
    end
  end

  def update_status
    @op = OrderProduct.find_by(id: params[:id])
    if @op.status == "shipped"
      @op.status = :pending      
    else @op.status == "pending"
      @op.status = :shipped
    end

    if @op.save
      flash[:status] = :success 
      flash[:message] = "Order \##{@op.id} status updated."
    else 
      flash[:status] = :error
      flash[:message] = "Failed to update Order \##{@op.id}"
      flash[:errors] = @op.errors.messages 
    end

    redirect_to dashboard_path
  end

  private

  def order_product_params
    params.require(:order_product).permit(:quantity, :product_id, :order_id, :status)
  end

  def find_order_product
    @order_product = OrderProduct.find_by(id: params[:id])
  end
end
