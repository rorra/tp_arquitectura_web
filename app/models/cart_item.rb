class CartItem < ApplicationRecord
  belongs_to :cart
  belongs_to :product

  validates :quantity,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than: 0,
              message: I18n.t("activerecord.errors.models.cart_item.attributes.quantity.greater_than_zero")
            }

  def total_price
    product.price * quantity
  end

  def display_total
    I18n.t("number.currency.format.format",
           n: total_price,
           u: I18n.t("number.currency.format.unit"))
  end
end
