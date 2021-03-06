class OrdersController < ApplicationController
  before_action :find_order, except: [:create, :checkout, :confirmation]

  def create
    @order = Order.new(order_params)
    if @order.save
      flash[:status] = :success
      flash[:message] = "Successfully created order #{@order.id}"
      redirect_to root_path
    else
      flash[:status] = :warning
      flash[:message] = "Could not create order"
      flash[:errors] = @order.errors
      redirect_to root_path
    end
  end

  def show
    unless @order
      render_404
      return
    end
  end

  def edit
    unless @order
      render_404
      return
    end
  end

  def update
    if @order.update(order_params)
      flash[:status] = :success
      flash[:message] = "Succesfully updated order #{@order.id}"
      redirect_to order_path(@order)
    else
      flash.now[:status] = :warning
      flash.now[:message] = "Could not update order #{@order.id}"
      flash[:errors] = @order.errors
      render :edit
    end
  end

  def current
    @order = @current_order
  end

  def checkout
    @order = @current_order
    @order.status = "paid"
    @order.update(order_params)
    @order.total_price = @order.checkout_amount
    if @order.save(context: :checkout)
      @order.order_products.each do |op|
        product = Product.find_by(id: op.product_id)
        if op.quantity > product.quantity
          flash.now[:status] = :error
          flash.now[:message] = "only #{product.quantity} units of #{product.name} are available; please adjust quantity"
          render :current, status: :bad_request
          return
        else
          product.quantity -= op.quantity
          product.save
        end
      end

      session[:order_id] = nil

      redirect_to order_confirmation_path(@order.uid)

      return
    else
      flash.now[:status] = :error
      flash.now[:message] = "Could not complete check out"
      flash.now[:errors] = @order.errors
      render :current
      return
    end
  end

  def confirmation
    @order = Order.find_by(uid: params[:uid])

    unless @order
      render_404
    end
  end

  def destroy
    @order.destroy

    flash[:status] = :success
    flash[:message] = "Successfully deleted order #{@order.id}"
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :address1, :city, :state, :zip, :expiration, :last_four_cc, :cvv, :status, :uid)
  end

  def find_order
    @order = Order.find_by(id: params[:id])
  end
end
