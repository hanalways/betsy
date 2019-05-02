class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :toggle_retire, :destroy]

  def new
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    if @product.save
      redirect_to product_path(@product.id)
      flash[:status] = :success
      flash[:message] = "You sucessfully created a new product"
    else
      render :new,
             flash.now[:status] = :error
      flash.now[:message] = "Failed to add product to database"
    end
  end

  def show
  end

  def index
    @products = Product.all
  end

  def update
    if @product.update product_params
      redirect_to product_path(@product.id)
      flash[:status] = :success
      flash[:message] = "sucessfully updated product"
    else
      render :edit
      flash.now[:status] = :error
      flash.now[:message] = "Failed to update product"
    end
  end

  def edit
  end

  def destroy
    if @product.destroy
      flash[:status] = :success
      flash[:message] = "sucessfully removed product from database"
    else
      redirect_to(product_path(@product.id))
      flash[:status] = :error
      flash[:message] = "Failed to remove product from database"
    end
  end

  def toggle_retire
    @product.retired = !@product.retired
  end

  def product_params
    return params.require(:product).permit(:image_url, :retired, :name, :price, :quantity, :description, :merchant_id)
  end

  def find_product
    @product = Product.find_by(id: params[:id])
    if !@product
      head :not_found
    end
  end
end
