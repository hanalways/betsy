class ApplicationController < ActionController::Base
  before_action :set_cart

  def set_cart
    @current_order = Order.find_by(id: session[:order_id])
    if !@current_order
      @current_order = Order.new
      @current_order.save
      session[:order_id] = @current_order.id
    end
  end
end
