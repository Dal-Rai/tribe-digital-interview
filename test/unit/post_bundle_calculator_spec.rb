require_relative '../rails_helper'

RSpec.describe PostBundleCalculator do
  let(:parser) { OrderParser.new(valid_order) }
  let(:types) { parser.item_types }
  let(:items) { parser.split_order }
  let(:subject) { described_class.new(items, types) }

  context 'When supplied order as a string' do
    it 'returns item type with bundles' do
      expect(subject.item_bundles).to eq(item_bundles)
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
      bundle, price = first_item_bundle_price
      item = "5 #{first_item_type}"
      expect(subject.fallback_price(first_item_type, item, 5)[:total]).to eql(5 * price / bundle)
    end
  end
end
