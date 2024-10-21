class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  def total_price
    product.price * quantity
  end

  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
