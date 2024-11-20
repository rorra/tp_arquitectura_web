class ProductsController < ApplicationController
  def index
    redirect_to root_path
  end

  def show
    @product = Product.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: t('views.products.not_found')
  end
end
