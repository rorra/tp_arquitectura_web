class CartsController < ApplicationController
  before_action :set_cart

  def show
    @cart_items = @cart.cart_items
  end

  def add_item
    product = Product.find(params[:product_id])
    @cart.add_product(product)
    redirect_to cart_path, notice: 'Product agregado.'
  end

  def remove_item
    product = Product.find(params[:product_id])
    @cart.remove_product(product)
    redirect_to cart_path, notice: 'Producto eliminado.'
  end

  def checkout
    if user_signed_in?
      @order = Order.new
    else
      redirect_to new_user_session_path, alert: 'Please sign in to proceed to checkout.'
    end
  end

  private

  def set_cart
    @cart = current_cart
  end
end
