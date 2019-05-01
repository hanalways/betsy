class ProductsController < ApplicationController
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
    @product = Product.find_by(id: params[:id])
    if !@product
      head :not_found
    end
  end

  def index
    @products.all
  end

  def update
    @product = Product.find_by(id: params[:id])
    if !@product
      head :not_found
    end
    if @product.update product_params
      redirect_to product_path(@product.id)
      flash[:status] = :sucess
      flash[:message] = "sucessfully updated product"
    else
      render :edit
      flash.now[:status] = :error
      flash.now[:message] = "Failed to update product"
    end
  end

  def edit
    @product = Product.find_by(id: params[:id])
    if !@product
      head :not_found
    end
  end

  def toggle_retire
    @product = Product.find_by(id: params[:id])
    if !@product
      head :not_found
    end
  end
end
