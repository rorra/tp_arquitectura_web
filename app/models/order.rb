class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, confirmed: 1, shipped: 2 }

  def total_price
    order_items.to_a.sum { |item| item.total_price }
  end
end
