require 'rails_helper'

RSpec.describe "Carts", type: :request do
  let(:user) { create(:user) }
  let(:product) { create(:product) }
  let(:cart) { create(:cart, user: user) }

  before { sign_in user }

  describe 'GET /cart' do
    it 'renders the show template successfully' do
      get cart_path
      expect(response).to be_successful
      expect(response.body).to include('Shopping Cart')
    end
  end

  describe 'POST /cart/add_item/:product_id' do
    it 'adds a product to the cart' do
      expect {
        post add_item_cart_path(product_id: product.id)
      }.to change(CartItem, :count).by(1)
      expect(response).to redirect_to(cart_path(locale: :en))
      expect(flash[:notice]).to eq(I18n.t('views.cart.added_to_cart'))
    end
  end

  describe 'DELETE /cart/remove_item/:product_id' do
    let!(:cart_item) { create(:cart_item, cart: cart, product: product) }

    before do
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

    it 'removes a product from the cart' do
      expect {
        delete remove_item_cart_path(product_id: product.id, remove_all: true)
      }.to change(CartItem, :count).by(-1)
      expect(response).to redirect_to(cart_path(locale: :en))
      expect(flash[:notice]).to eq(I18n.t('views.cart.removed_from_cart'))
    end
  end
end
