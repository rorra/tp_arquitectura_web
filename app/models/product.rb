class Product < ApplicationRecord
  belongs_to :category
  has_many :cart_items, dependent: :destroy
  has_many :order_items, dependent: :destroy

  # Product images
  has_one_attached :main_image
  has_many_attached :additional_images

  validates :name, :price, :stock, presence: true
  validates :price, numericality: {
    greater_than_or_equal_to: 0,
    message: -> { I18n.t("activerecord.errors.models.product.attributes.price.greater_than_or_equal_to_zero") }
  }
  validates :stock, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 0,
    message: -> { I18n.t("activerecord.errors.models.product.attributes.stock.greater_than_or_equal_to_zero") }
  }

  scope :featured, -> { where(featured: true) }

  def display_price
    I18n.t("number.currency.format.format",
           n: price,
           u: I18n.t("number.currency.format.unit"))
  end

  def stock_status
    if stock > 0
      I18n.t("activerecord.attributes.product.in_stock", count: stock)
    else
      I18n.t("activerecord.attributes.product.out_of_stock")
    end
  end
end
