require 'rails_helper'

RSpec.describe OrdersHelper, type: :helper do
  describe '#order_status_color' do
    it 'returns correct color for pending status' do
      expect(helper.order_status_color('pending')).to eq('warning')
    end

    it 'returns correct color for paid status' do
      expect(helper.order_status_color('paid')).to eq('info')
    end

    it 'returns correct color for shipped status' do
      expect(helper.order_status_color('shipped')).to eq('success')
    end

    it 'returns correct color for cancelled status' do
      expect(helper.order_status_color('cancelled')).to eq('danger')
    end

    it 'returns secondary for unknown status' do
      expect(helper.order_status_color('unknown')).to eq('secondary')
    end
  end
end
