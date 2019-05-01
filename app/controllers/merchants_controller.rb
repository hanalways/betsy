class MerchantsController < ApplicationController
  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find_by(id: params[:id])
    unless @merchant 
      head :not_found
      return
    end
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
        flash[:error] = "Could not create new user account: #{merchant.errors.messages}"
        return redirect_to merchants_path
      end
    end

    session[:user_id] = merchant.id 
    return redirect_to merchants_path
  end

  def destroy 
    session[:user_id] = nil 
    flash[:status] = :success 
    flash[:message] = "Successfully logged out!"

    redirect_to merchants_path
  end
end
