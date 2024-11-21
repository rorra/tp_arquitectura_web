class CartsController < ApplicationController
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart.add_product(product)
    redirect_to cart_path, notice: t("views.cart.added_to_cart")
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path, alert: t("views.cart.product_not_found")
  end

  def remove_item
    product = Product.find(params[:product_id])
    @cart.remove_product(product, remove_all: params[:remove_all].present?)
    redirect_to cart_path, notice: t("views.cart.removed_from_cart")
  rescue ActiveRecord::RecordNotFound
    redirect_to cart_path, alert: t("views.cart.product_not_found")
  end

  def checkout
    if user_signed_in?
      @order = Order.new
    else
      redirect_to new_user_session_path, alert: t("views.cart.sign_in_to_checkout")
    end
  end

  private

  def set_cart
    @cart = current_cart
  end
end
