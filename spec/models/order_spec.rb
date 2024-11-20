require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:user) { User.create!(name: "Test User", email: "test@example.com", password: "password") }

  describe 'validations' do
    it 'requires shipping information' do
      order = Order.new(user: user)
      expect(order).not_to be_valid
      expect(order.errors[:state]).to include("can't be blank")
      expect(order.errors[:city]).to include("can't be blank")
      expect(order.errors[:zip]).to include("can't be blank")
      expect(order.errors[:address]).to include("can't be blank")
      expect(order.errors[:phone]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:order_items).dependent(:destroy) }
    it { should have_many(:products).through(:order_items) }
  end

  describe 'status enum' do
    let(:order) {
      Order.create!(
        user: user,
        state: 'CA',
        city: 'LA',
        zip: '90210',
        address: '123 Test St',
        phone: '1234567890',
        total_price: 100.00
      )
    }

    it 'has the correct statuses' do
      expect(order).to define_enum_for(:status)
                         .with_values(pending: 0, paid: 1, shipped: 2, cancelled: 3)
    end

    it 'defaults to pending status' do
      expect(order.status).to eq('pending')
    end
  end

  describe '#calculate_total' do
    let(:category) { Category.create!(name: "Electronics") }
    let(:product1) { Product.create!(name: "Product 1", price: 100.00, stock: 10, category: category) }
    let(:product2) { Product.create!(name: "Product 2", price: 200.00, stock: 10, category: category) }
    let(:order) {
      Order.create!(
        user: user,
        state: 'CA',
        city: 'LA',
        zip: '90210',
        address: '123 Test St',
        phone: '1234567890',
        total_price: 0
      )
    }

    it 'calculates the total price of all order items' do
      OrderItem.create!(order: order, product: product1, quantity: 2, unit_price: product1.price)
      OrderItem.create!(order: order, product: product2, quantity: 1, unit_price: product2.price)
      expect(order.calculate_total).to eq(400.00)  # (100 * 2) + (200 * 1)
    end
  end
end
