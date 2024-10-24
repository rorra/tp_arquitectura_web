class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy

  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.quantity += 1
    else
      current_item = cart_items.build(product: product)
      current_item.quantity = 1
    end
    current_item.save
  end

  def remove_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      if current_item.quantity > 1
        current_item.quantity -= 1
        current_item.save
      else
        current_item.destroy
      end
    end
  end
end
