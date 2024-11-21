class CategoriesController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: t("views.categories.not_found")
  end
end
