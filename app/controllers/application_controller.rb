class ApplicationController < ActionController::Base
  before_action :set_cart, :set_merchant

  def set_cart
    @current_order = Order.find_by(id: session[:order_id])
    if !@current_order
      @current_order = Order.new
      @current_order.status = "pending"
      @current_order.uid = SecureRandom.uuid
      @current_order.save
      session[:order_id] = @current_order.id
    end
  end

  def require_login
    set_merchant
    unless @current_merchant
      flash[:status] = :error
      flash[:message] = "You must be logged in to access this section"
      redirect_to root_path
    end
  end

  def set_merchant
    @current_merchant = Merchant.find_by(id: session[:user_id])
  end
end
