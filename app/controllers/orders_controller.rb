class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_order, only: [:show, :cancel]
  before_action :check_cart_not_empty, only: [:new, :create]

  def index
    @orders = current_user.orders.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
  end

  def new
    @order = current_user.orders.build
  end

  def create
    @order = current_user.orders.build(order_params)

    # Set initial total price from cart
    @order.total_price = current_cart.total_price

    Order.transaction do
      if @order.save
        # Transfer items from cart to order
        current_cart.cart_items.each do |cart_item|
          @order.order_items.create!(
            product: cart_item.product,
            quantity: cart_item.quantity,
            unit_price: cart_item.product.price
          )
        end

        # Clear the cart
        current_cart.cart_items.destroy_all

        # Redirect to payment
        redirect_to new_payment_path(order_id: @order.id), notice: 'Order was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def cancel
    if @order.may_cancel?
      @order.cancelled!
      redirect_to @order, notice: 'Order was successfully cancelled.'
    else
      redirect_to @order, alert: 'This order cannot be cancelled.'
    end
  end

  private

  def set_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:state, :city, :zip, :address, :phone)
  end

  def check_cart_not_empty
    if current_cart.cart_items.empty?
      redirect_to cart_path, alert: 'Your cart is empty. Please add some items before checking out.'
    end
  end
end