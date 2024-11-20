module CartsHelper
  def cart_status_message(cart)
    if cart.cart_items.empty?
      t('views.orders.cart_empty')
    else
      t('views.cart.added_to_cart')
    end
  end

  def removed_from_cart_message
    t('views.cart.removed_from_cart')
  end
end
