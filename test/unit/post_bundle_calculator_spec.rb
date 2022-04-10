require_relative '../rails_helper'

RSpec.describe PostBundleCalculator do
  let(:order) { "10 IMG 15 FLAC 13 VID" }
  let(:parser) { OrderParser.new(order) }
  let(:item_types) { parser.item_types }
  let(:items) { parser.split_order }
  let(:subject) { described_class.new(items, item_types) }

  context 'When supplied posts as a string' do
    it 'returns post type with bundles' do
      expect(subject.item_bundles).to eq(media_bundles)
    end
  end

  context 'When bundle and sum is supplied' do
    it 'returns the most appropriate combination' do
      result = []
      subject.find_bundles([5, 10], 25, 0, result, [])
      expect(result.last).to eq([5, 10, 10])
    end
  end

  context "When combination sum of bundles doesn't match the total" do
    it 'returns price by computing fallback price' do
      type = BUNDLE_PRICE.keys.first
      total, sum = BUNDLE_PRICE[type][0].first
      item = "5 #{type}"
      expect(subject.fallback_price(type, item, 5)[:total]).to eql(5 * sum/total)
    end
  end
end
