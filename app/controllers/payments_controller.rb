class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.find(params[:order_id])
  end

  def create
    @order = Order.find(params[:order_id])
    preference_data = {
      items: @order.cart_items.map do |item|
        {
          title: item.product.name,
          unit_price: item.product.price,
          quantity: item.quantity
        }
      end,
      payer: {
        name: current_user.name,
        email: current_user.email
      },
      back_urls: {
        success: payment_success_url(order_id: @order.id),
        failure: payment_failure_url(order_id: @order.id)
      }
    }

    sdk = Mercadopago::SDK.new(ENV['MERCADOPAGO_ACCESS_TOKEN'])
    preference = sdk.preference.create(preference_data)
    if preference['response']
      redirect_to preference['response']['sandbox_init_point']
    else
      redirect_to cart_path, alert: 'There was an error connecting to MercadoLibre.'
    end
  end

  def success
    @order = Order.find(params[:order_id])
    @order.update(status: 'paid')
    current_cart.cart_items.destroy_all
    redirect_to order_path(@order), notice: 'Payment was successful! Your order is now complete.'
  end

  def failure
    @order = Order.find(params[:order_id])
    redirect_to cart_path, alert: 'Payment failed. Please try again or use a different payment method.'
  end
end
