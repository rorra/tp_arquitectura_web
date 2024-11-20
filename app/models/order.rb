class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  enum status: { pending: 0, paid: 1, shipped: 2, cancelled: 3 }

  validates :state, :city, :zip, :address, :phone, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def add_items_from_cart(cart)
    cart.cart_items.each do |cart_item|
      order_items.build(
        product: cart_item.product,
        quantity: cart_item.quantity,
        unit_price: cart_item.unit_price
      )
    end
  end

  def calculate_total
    order_items.sum { |item| item.quantity * item.unit_price }
  end

  def may_cancel?
    pending?
  end
end