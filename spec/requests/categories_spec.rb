require 'rails_helper'

RSpec.describe "Categories", type: :request do
  let(:category) { create(:category) }
  let!(:products) { create_list(:product, 3, category: category) }

  describe 'GET /categories/:id' do
    it 'renders the show template successfully' do
      get category_path(category)
      expect(response).to be_successful
      expect(response.body).to include(category.name)
    end

    it 'displays all products in the category' do
      get category_path(category)
      products.each do |product|
        expect(response.body).to include(product.name)
      end
    end
  end
end
