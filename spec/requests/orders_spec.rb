require 'rails_helper'

RSpec.describe "Orders", type: :request do
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'GET /orders' do
    let!(:orders) { create_list(:order, 3, user: user) }

    it 'renders the index template successfully' do
      get orders_path
      expect(response).to be_successful
      expect(response.body).to include('Orders')
    end

    it 'lists all orders for the user' do
      get orders_path
      orders.each do |order|
        expect(response.body).to include(order.id.to_s)
      end
    end
  end

  describe 'GET /orders/:id' do
    let(:order) { create(:order, user: user) }

    it 'renders the show template successfully' do
      get order_path(order)
      expect(response).to be_successful
      expect(response.body).to include("Order ##{order.id}")
    end
  end

  describe 'GET /orders/new' do
    context 'with items in cart' do
      before do
        cart = create(:cart, user: user)
        create(:cart_item, cart: cart)
        session_double = double('session')
        allow(session_double).to receive(:[]).and_return(cart.id)
        allow(session_double).to receive(:[]=)
        allow(session_double).to receive(:enabled?).and_return(true)
        allow(session_double).to receive(:loaded?).and_return(true)
        allow(session_double).to receive(:key?).and_return(true)
        allow_any_instance_of(ActionDispatch::Request)
          .to receive(:session)
                .and_return(session_double)
      end

      it 'renders the new template successfully' do
        get new_order_path
        expect(response).to be_successful
        expect(response.body).to include('Checkout')
      end
    end

    context 'with empty cart' do
      it 'redirects to cart with alert' do
        get new_order_path
        expect(response).to redirect_to(cart_path(locale: :en))
        expect(flash[:alert]).to include(I18n.t('views.cart.empty_cart'))
      end
    end
  end
end
