require 'rails_helper'

RSpec.describe Search::Resource do
  let(:language){ Search::Resource.new Rails.root.join('spec', 'fixtures', 'data.json') }

  context 'with simple query' do
    it 'find results' do
      expect(language.find('Lisp Common')).to include language.fetch 26
    end
  end
end
