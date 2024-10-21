class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items
  has_many :order_items

  # Validation examples
  validates :name, :price, :stock, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
