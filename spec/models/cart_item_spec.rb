require 'rails_helper'

RSpec.describe CartItem, type: :model do
  describe 'associations' do
    it { should belong_to(:cart) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
  end

  describe '#total_price' do
    let(:product) { create(:product, price: 100.00) }
    let(:cart_item) { create(:cart_item, product: product, quantity: 3) }

    it 'calculates the total price correctly' do
      expect(cart_item.total_price).to eq(300.00)
    end
  end
end
