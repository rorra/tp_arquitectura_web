class OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.cart_items = current_cart.cart_items
    if @order.save
      redirect_to mercadolibre_payment_path(@order)
    else
      render :new, alert: 'There was an error processing your order.'
    end
  end

  private

  def order_params
    params.require(:order).permit(:province, :postal_code, :address, :phone)
  end
end
