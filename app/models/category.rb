class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true, uniqueness: true

  scope :with_products, -> { includes(:products).where.not(products: { id: nil }) }
end
