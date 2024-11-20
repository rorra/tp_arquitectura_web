class PagesController < ApplicationController
  def home
    @categories = Category.all
    @featured_products = Product.featured.limit(5)
    flash.now[:notice] = t('views.pages.welcome_message') if @categories.empty?
  end
end
