require 'format_validator'
# require_relative '../test_helper'
require 'pry'

describe 'FormatValidator' do
  context 'When supplied valid format post' do
    it 'returns true' do
      binding.pry
      BUNDLE_PRICE = YAML.load_file(File.join(Rails.root, 'config', 'bundle_price.yml'))
      expect(FormatValidator.valid_format?(['IMG', 'FLAC', 'VID'])).to eq(true)
    end
  end

  context 'When supplied valid format post' do
    it 'returns false' do
      expect(FormatValidator.valid_format?(['IMG', 'FLAC', 'VID', 'PDF'])).to eq(false)
    end
  end
end
