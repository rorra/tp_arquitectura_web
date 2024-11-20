class ApplicationController < ActionController::Base
  include ActiveStorage::SetCurrent

  before_action :set_locale

  helper_method :current_cart

  private

  def current_cart
    if session[:cart_id]
      @current_cart ||= Cart.find_by(id: session[:cart_id])
    end

    if @current_cart.nil?
      @current_cart = Cart.create!
      session[:cart_id] = @current_cart.id
    end

    @current_cart
  end

  def set_locale
    I18n.locale = I18n.available_locales.include?(params[:locale]&.to_sym) ? params[:locale] : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
