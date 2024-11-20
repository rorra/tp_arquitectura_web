require 'rails_helper'

RSpec.describe Cart, type: :model do
  let(:user) { User.create!(name: "Test User", email: "test@example.com", password: "password") }
  let(:category) { Category.create!(name: "Electronics") }
  let(:product) { Product.create!(name: "Test Product", price: 100.00, stock: 10, category: category) }
  let(:cart) { Cart.create!(user: user) }

  describe 'associations' do
    it { should belong_to(:user).optional }
    it { should have_many(:cart_items).dependent(:destroy) }
  end

  describe '#add_product' do
    it 'creates a new cart item when product is not in cart' do
      expect {
        cart.add_product(product)
      }.to change(cart.cart_items, :count).by(1)
    end

    it 'increases quantity when product is already in cart' do
      cart.add_product(product)
      cart.add_product(product)
      cart_item = cart.cart_items.find_by(product: product)
      expect(cart_item.quantity).to eq(2)
    end
  end

  describe '#remove_product' do
    before { cart.add_product(product) }

    it 'decreases quantity by 1 when remove_all is false' do
      cart.add_product(product)  # quantity = 2
      cart.remove_product(product, remove_all: false)
      cart_item = cart.cart_items.find_by(product: product)
      expect(cart_item.quantity).to eq(1)
    end

    it 'removes the cart item when remove_all is true' do
      expect {
        cart.remove_product(product, remove_all: true)
      }.to change(cart.cart_items, :count).by(-1)
    end
  end

  describe '#total_price' do
    it 'calculates the total price of all items in cart' do
      cart.add_product(product)
      cart.add_product(product)
      expect(cart.total_price).to eq(200.00)
    end
  end
end
