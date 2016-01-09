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
    it 'support exact matches' do
      results = subject.find('Interpreted "Thomas Eugene"')
      expect(results).to include subject.fetch 12 # basic
      expect(results).to_not include subject.fetch 48 # but not haskell
    end

    it 'match in different fields' do
      results = subject.find('Scripting Microsoft')
      results.each do |language|
        expect(language['Designed by']).to include 'Microsoft'
      end
    end

    it 'support for negative searches' do
      results = subject.find('john -array')
      # include
      expect(results).to include subject.fetch 12 # BASIC
      expect(results).to include subject.fetch 48 # Haskell
      expect(results).to include subject.fetch 60 # Lisp
      expect(results).to include subject.fetch 78 # S-Lang
      # but not include
      expect(results).to_not include subject.fetch 19 # Chapel
      expect(results).to_not include subject.fetch 42 # Fortran
      expect(results).to_not include subject.fetch 77 # S
    end

    it 'simple query' do
      expect(subject.find('Lisp Common')).to include subject.fetch 26
    end

    it 'simple query with thrash symbols' do
      expect(subject.find(' Lisp! Common !!,....')).to include subject.fetch 26
    end
  end

  describe '#fetch' do
    it 'return one record' do
      language = subject.fetch 22
      expect(language['Name']).to eq 'Clojure'
    end
  end
end
