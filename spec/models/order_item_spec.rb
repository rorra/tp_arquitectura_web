require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price).is_greater_than_or_equal_to(0) }
  end

  describe '#total_price' do
    let(:order_item) { create(:order_item, quantity: 2, unit_price: 50.00) }

    it 'calculates the total price correctly' do
      expect(order_item.total_price).to eq(100.00)
    end
  end
end
