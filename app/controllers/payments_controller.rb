require 'mercadopago'

class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.find(params[:order_id])

    redirect_to orders_path, alert: 'This order is already paid.' unless @order.pending?
  end

  def create
    @order = Order.find(params[:order_id])

    preference_data = {
      items: @order.order_items.map do |item|
        {
          title: item.product.name,
          unit_price: item.unit_price.to_f,
          quantity: item.quantity
        }
      end,
      payer: {
        name: current_user.name,
        email: current_user.email
      },
      back_urls: {
        success: success_payments_url(order_id: @order.id),
        failure: failure_payments_url(order_id: @order.id)
      }
    }

    access_token = Rails.application.credentials[:mercadopago_access_token]
    sdk = Mercadopago::SDK.new(access_token)
    preference = sdk.preference.create(preference_data)
    if preference[:response]
      redirect_to preference[:response]['sandbox_init_point'], allow_other_host: true
    else
      redirect_to cart_path, alert: 'There was an error connecting to the payment gateway.'
    end
  end

  def success
    @order = Order.find(params[:order_id])
    payment_id = params[:payment_id]

    if payment_id
      # Initialize MercadoPago SDK
      access_token = Rails.application.credentials[:mercadopago_access_token]
      sdk = Mercadopago::SDK.new(access_token)

      # Fetch payment info from MercadoPago
      payment = sdk.payment.get(payment_id)

      # Check if the payment was approved
      if payment[:response] && payment[:response]["status"] == "approved"
        @order.update(status: 'paid')
        current_cart.cart_items.destroy_all
        redirect_to order_path(@order), notice: 'Payment was successful! Your order is now complete.'
      else
        redirect_to cart_path, alert: 'Payment verification failed. Please contact support.'
      end
    else
      redirect_to cart_path, alert: 'Invalid payment confirmation details.'
    end
  end

  def failure
    @order = Order.find(params[:order_id])
    redirect_to cart_path, alert: 'Payment failed. Please try again or use a different payment method.'
  end
end
