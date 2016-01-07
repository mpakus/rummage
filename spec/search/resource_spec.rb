require 'rails_helper'

RSpec.describe Search::Resource do
  context 'when file is correct' do
    it 'process correct' do
      Search::Resource.new Rails.root.join('spec', 'fixtures', 'data.json')
    end
  end

  context 'when file not found' do
    it 'throw exception' do
      expect { Search::Resource.new('wrong_file_name.json') }.to raise_exception(Errno::ENOENT)
    end
  end

  context 'when json is invalid' do
    it 'throw exception' do
      expect {
        Search::Resource.new Rails.root.join('spec', 'fixtures', 'invalid.json')
      }.to raise_exception(JSON::ParserError)
    end
  end
end
