require_relative '../rails_helper'

describe 'FormatValidator' do
  context 'When supplied valid format post' do
    it 'returns true' do
      expect(FormatValidator.valid_format?(BUNDLE_PRICE.keys)).to eq(true)
    end
  end

  context 'When supplied invalid format post' do
    it 'returns false' do
      expect(FormatValidator.valid_format?(BUNDLE_PRICE.keys << 'GIF123')).to eq(false)
    end
  end

  context 'When supplied invalid format post' do
    it 'returns allowed formats message' do
      expect(FormatValidator.allowed_format_msg).to eq("Allowed formats are #{BUNDLE_PRICE.keys.to_sentence}")
    end
  end
end
