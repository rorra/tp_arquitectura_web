class Cart < ApplicationRecord
  belongs_to :user, optional: true
  has_many :cart_items, dependent: :destroy

  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
      current_item.save
    else
      cart_items.create!(
        product: product,
        quantity: 1,
        unit_price: product.price
      )
    end
  end

  def remove_product(product, remove_all: false)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      if remove_all
        current_item.destroy
      elsif current_item.quantity > 1
        current_item.quantity -= 1
        current_item.save
      else
        current_item.destroy
      end
    end
  end

  def total_price
    cart_items.sum { |item| item.quantity * item.unit_price }
  end

  def display_total
    I18n.t("number.currency.format.format",
           n: total_price,
           u: I18n.t("number.currency.format.unit"))
  end
end
