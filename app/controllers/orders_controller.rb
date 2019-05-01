class OrdersController < ApplicationController
  before_action :find_order, except: [:create]

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:status] = :success
      flash[:message] = "Successfully created order #{@order.id}"
      redirect_to root_path
    end
  end

  def show
    unless @order
      head :not_found
      return
    end
  end

  def edit
    unless @order
      head :not_found
      return
    end
  end

  def update
    if @order.update(order_params)
      flash[:status] = :success
      flash[:message] = "Succesfully updated order #{@order.id}"
      redirect_to :show
    else
      flash.now[:status] = :warning
      flash.now[:message] = "Could not update order #{@order.id}"
      render :edit
    end
  end

  private

  def order_params
    params.require(:order).permit(:email, :address1, :city, :state, :zip, :expiration)
  end

  def find_order
    @order = Order.find_by(params[:id])
  end
end
