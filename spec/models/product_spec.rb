require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      product = build(:product)
      expect(product).to be_valid
    end

    it 'is not valid without a name' do
      product = build(:product, name: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid without a price' do
      product = build(:product, price: nil)
      expect(product).not_to be_valid
    end

    it 'is not valid with a negative price' do
      product = build(:product, price: -10)
      expect(product).not_to be_valid
    end
  end

  describe 'associations' do
    it { should belong_to(:category) }
    it { should have_many(:cart_items) }
    it { should have_many(:order_items) }
  end

  describe 'scopes' do
    let!(:featured_product) { create(:product, :featured) }
    let!(:regular_product) { create(:product) }

    it 'returns featured products' do
      expect(Product.featured).to include(featured_product)
      expect(Product.featured).not_to include(regular_product)
    end
  end
end
