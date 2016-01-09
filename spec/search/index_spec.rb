require 'rails_helper'

RSpec.describe Search::Index do
  let(:index) { Search::Index.new(db: load_data).fetch }

  it 'check name index' do
    expect(index['basic']).to include 12 # BASIC
    expect(index['basic']).to include 88 # Visual Basic
    expect(index['visual']).to eq Set.new [88, 89]
  end

  it 'check type field' do
    expect(index['compiled']).to include 88
    expect(index['compiled']).to include 89
    expect(index['compiled']).to include 91

    expect(index['procedural']).to include 91
    expect(index['procedural']).to include 94
    expect(index['procedural']).to include 20
  end

  it 'check designed by field' do
    expect(index['ibm']).to include 74
    expect(index['microsoft']).to include 87
    expect(index['microsoft']).to include 88
    expect(index['microsoft']).to include 89
  end

  private

  def load_data
    JSON.parse File.read Rails.root.join('spec', 'fixtures', 'data.json')
  end
end
