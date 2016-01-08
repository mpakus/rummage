require 'rails_helper'

RSpec.describe Search::Resource do
  subject { Search::Resource.new Rails.root.join('spec', 'fixtures', 'data.json') }

  describe '.new' do
    context 'when file is correct' do
      it { is_expected.to be_kind_of Search::Resource }
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

  describe '#find' do
    it 'simple query' do
      expect(subject.find('Lisp Common')).to include subject.fetch 26
    end

    it 'simple query with thrash symbols' do
      expect(subject.find(' Lisp! Common !!,....')).to include subject.fetch 26
    end

    it 'except query with -' do
    end

    it 'find full "request string"' do
    end
  end

  describe '#fetch' do
    it 'returns one record' do
      language = subject.fetch 22
      expect(language['Name']).to eq 'Clojure'
    end
  end
end
