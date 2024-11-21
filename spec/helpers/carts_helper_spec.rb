require 'rails_helper'

RSpec.describe CartsHelper, type: :helper do
  describe '#cart_status_message' do
    let(:cart) { build_stubbed(:cart) }

    context 'with empty cart' do
      before do
        allow(cart).to receive_message_chain(:cart_items, :empty?).and_return(true)
      end

      it 'returns empty cart message' do
        expect(helper.cart_status_message(cart)).to eq(I18n.t('views.orders.cart_empty'))
      end
    end

    context 'with items in cart' do
      before do
        allow(cart).to receive_message_chain(:cart_items, :empty?).and_return(false)
      end

      it 'returns added to cart message' do
        expect(helper.cart_status_message(cart)).to eq(I18n.t('views.cart.added_to_cart'))
      end
    end
  end

  describe '#removed_from_cart_message' do
    it 'returns the correct message' do
      expect(helper.removed_from_cart_message).to eq(I18n.t('views.cart.removed_from_cart'))
    end
  end
end
