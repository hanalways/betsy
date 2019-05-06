class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:status] = :success
      flash[:message] = "Successfully created category #{@category.name}"
      redirect_back fallback_location: root_path
    else
      flash.now[:status] = :warning
      flash.now[:message] = "Could not create category"
      flash.now[:errors] = @order.errors
      render :new
    end
  end
end

private

def category_params
  return params.require(:category).permit(:name)
end
