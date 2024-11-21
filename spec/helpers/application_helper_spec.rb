require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#page_title' do
    it 'returns base title when no title is provided' do
      expect(helper.page_title).to eq(I18n.t("site.name"))
    end

    it 'returns formatted title when title is provided' do
      expect(helper.page_title("Test Page")).to eq("Test Page - #{I18n.t("site.name")}")
    end
  end

  describe '#flash_class' do
    it 'returns alert-success for notice' do
      expect(helper.flash_class(:notice)).to eq("alert-success")
    end

    it 'returns alert-danger for error' do
      expect(helper.flash_class(:error)).to eq("alert-danger")
    end

    it 'returns alert-warning for alert' do
      expect(helper.flash_class(:alert)).to eq("alert-warning")
    end

    it 'returns alert-info for unknown type' do
      expect(helper.flash_class(:unknown)).to eq("alert-info")
    end
  end

  describe '#current_locale_name' do
    it 'returns the current locale name' do
      allow(I18n).to receive(:locale).and_return(:en)
      expect(helper.current_locale_name).to eq(I18n.t("locales.en"))
    end
  end

  describe '#format_date' do
    let(:date) { Date.new(2024, 2, 15) }

    it 'formats date according to locale' do
      expect(helper.format_date(date)).to eq(I18n.l(date, format: :default))
    end

    it 'returns nil for nil date' do
      expect(helper.format_date(nil)).to be_nil
    end
  end

  describe '#format_currency' do
    it 'formats currency according to locale' do
      allow(I18n).to receive(:locale).and_return(:en)
      expect(helper.format_currency(1234.56)).to eq("$1,234.56")
    end
  end
end
