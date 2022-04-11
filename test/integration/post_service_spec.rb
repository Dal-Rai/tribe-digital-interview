require_relative '../rails_helper'

RSpec.describe PostService do
  let(:valid_post) { described_class.new(valid_order) }
  let(:invalid_type_post) { described_class.new(invalid_type_order) }
  let(:no_combination_sum_post) { described_class.new(no_combination_sum) }

  context 'When supplied valid order' do
    it 'returns items and sub items' do
      order_item = valid_post.item_prices[first_item_type]
      sub_items = order_item[:sub_items]
      expect(valid_post.item_prices.count).to eq(item_types.count)
      expect(sub_items.pluck(:bundle).sum).to eq(order_item[:item].to_i)
      expect(order_item[:total]).to eq(sub_items.pluck(:total).sum)
      expect(valid_post.print_result[first_item_type][:sub_items].empty?).to be false
    end
  end

  context 'When invalid order in supplied' do
    it 'returns empty item prices' do
      expect(invalid_type_post.item_prices.empty?).to eql(true)
      expect(invalid_type_post.send(:calculator).valid_order?).to eql(false)
      expect(invalid_type_post.print_result).to be nil
    end
  end

  context "When combination sum of bundles doesn't match the total" do
    it 'returns price by computing fallback price' do
      order_item = no_combination_sum_post.item_prices[first_item_type]
      sub_items = order_item[:sub_items]
      expect(sub_items.count).to be 0
      expect(order_item[:total]).to be_positive
    end
  end
end
