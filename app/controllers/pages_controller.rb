class PagesController < ApplicationController
  def home
    @categories = Category.all
    @featured_products = Product.featured.limit(5)
  end
end
