require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    subject { create(:category) } # Create a valid category first

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:products) }
  end

  describe 'scopes' do
    let!(:category_with_products) { create(:category) }
    let!(:category_without_products) { create(:category) }
    let!(:product) { create(:product, category: category_with_products) }

    describe '.with_products' do
      it 'returns only categories with products' do
        expect(Category.with_products).to include(category_with_products)
        expect(Category.with_products).not_to include(category_without_products)
      end
    end
  end
end
