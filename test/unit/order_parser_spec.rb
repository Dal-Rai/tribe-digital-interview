require_relative '../rails_helper'

RSpec.describe OrderParser do
  let(:post) { "10 IMG 15 FLAC 13 VID" }
  let(:subject) { described_class.new(post) }

  context 'When supplied order as a string' do
    it 'returns item types' do
      expect(subject.item_types).to eq(post.split.select { |i| i[0] =~ /^[a-zA-Z]/ })
    end

    it 'returns splitted items' do
      expect(subject.split_order).to eq(post.scan(/(\d+\ \w+)/).flatten)
    end
  end
end
