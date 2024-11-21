require "mercadopago"
class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.find(params[:order_id])
    redirect_to orders_path, alert: t("views.payments.already_paid") unless @order.pending?
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: t("views.payments.order_not_found")
  end

  def create
    @order = Order.find(params[:order_id])
    preference_data = build_preference_data
    process_payment_preference(preference_data)
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: t("views.payments.order_not_found")
  end

  def success
    @order = Order.find(params[:order_id])
    payment_id = params[:payment_id]

    if payment_id
      process_successful_payment
    else
      redirect_to cart_path, alert: t("views.payments.invalid_confirmation")
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: t("views.payments.order_not_found")
  end

  def failure
    @order = Order.find(params[:order_id])
    redirect_to cart_path, alert: t("views.payments.payment_failed")
  rescue ActiveRecord::RecordNotFound
    redirect_to orders_path, alert: t("views.payments.order_not_found")
  end

  private

  def build_preference_data
    {
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
  end

  def process_payment_preference(preference_data)
    access_token = Rails.application.credentials[:mercadopago_access_token]
    sdk = Mercadopago::SDK.new(access_token)
    preference = sdk.preference.create(preference_data)

    if preference[:response]
      redirect_to preference[:response]["sandbox_init_point"], allow_other_host: true
    else
      redirect_to cart_path, alert: t("views.payments.gateway_error")
    end
  end

  def process_successful_payment
    access_token = Rails.application.credentials[:mercadopago_access_token]
    sdk = Mercadopago::SDK.new(access_token)
    payment = sdk.payment.get(params[:payment_id])

    if payment[:response] && payment[:response]["status"] == "approved"
      @order.update(status: "paid")
      current_cart.cart_items.destroy_all
      redirect_to order_path(@order), notice: t("views.payments.success")
    else
      redirect_to cart_path, alert: t("views.payments.verification_failed")
    end
  end
end
