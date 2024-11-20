require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:category) { create(:category) }
  let(:product) { create(:product, category: category) }

  describe 'GET /products/:id' do
    it 'renders the show template successfully' do
      get product_path(product)
      expect(response).to be_successful
      expect(response.body).to include(product.name)
    end

    it 'displays the product details' do
      get product_path(product)
      expect(response.body).to include(product.name)
      expect(response.body).to include(product.description)
    end
  end
end
