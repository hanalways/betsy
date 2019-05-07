class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :toggle_retire, :destroy]
  before_action :require_login, except: [:index, :show, :homepage]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.merchant_id = @current_merchant.id

    if @product.save
      flash[:status] = :success
      flash[:message] = "You sucessfully created a new product"
      redirect_to product_path(@product.id)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Failed to add product to database"
      flash.now[:errors] = @product.errors.messages
      render :new
    end
  end

  def show
    @order_product = OrderProduct.new
    @review = Review.new
  end

  def index
    @products = Product.all
  end

  def update
    if @product.update product_params
      flash[:status] = :success
      flash[:message] = "Sucessfully updated product"
      redirect_to product_path(@product.id)
    else
      flash.now[:status] = :error
      flash.now[:message] = "Failed to update product"
      flash.now[:errors] = @product.errors.messages
      render :edit
    end
  end

  def edit
  end

  def destroy
    if @product.destroy
      flash[:status] = :success
      flash[:message] = "sucessfully removed product from database"
    else
      flash[:status] = :error
      flash[:message] = "Failed to remove product from database"
      flash[:errors] = @product.errors.messages
      redirect_to(product_path(@product.id))
    end
  end

  def toggle_retire
    @product.retired = !@product.retired
    @product.save
  end

  def homepage
    @products = Product.all.first(10)
  end

  private

  def product_params
    return params.require(:product).permit(
             :image_url,
             :retired,
             :name,
             :price,
             :quantity,
             :description,
           )
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    if !@product
      head :not_found
    end
  end
end
