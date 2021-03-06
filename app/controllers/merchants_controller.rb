class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    check_merchant
  end

  def create
    auth_hash = request.env["omniauth.auth"]
    merchant = Merchant.find_by(uid: auth_hash[:uid], provider: "github")

    if merchant
      flash[:status] = :success
      flash[:message] = "Logged in as returning user #{merchant.username}"
    else
      merchant = Merchant.build_from_github(auth_hash)

      if merchant.save
        flash[:status] = :success
        flash[:message] = "Logged in as new user #{merchant.username}"
      else
        flash[:status] = :error
        flash[:message] = "Could not create new user account: #{merchant.errors.messages}"
        flash[:errors] = merchant.errors
        return redirect_to root_path
      end
    end

    session[:user_id] = merchant.id
    return redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:status] = :success
    flash[:message] = "Successfully logged out!"

    redirect_to merchants_path
  end

  def dashboard
    @merchant = @current_merchant

    check_merchant
  end

  def confirmation
    @merchant = @current_merchant
    @order = Order.find_by(id: params[:id])

    check_merchant
  end

  private

  def check_merchant
    unless @merchant
      render_404
    end
  end
end
