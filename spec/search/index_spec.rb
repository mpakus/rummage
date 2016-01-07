require 'rails_helper'

RSpec.describe Search::Index do
  let(:index) { Search::Index.new(db: input).fetch }

  it 'check name index' do
    expect(index['basic']).to include 2
    expect(index['foxpro']).to include 3
    expect(index['visual']).to eq Set.new [2, 3]
  end

  it 'check type field' do
    expect(index['compiled']).to eq Set.new [0, 2, 3, 4, 5]
    expect(index['procedural']).to eq Set.new [0, 2, 3, 4]
  end

  it 'check designed by field' do
    expect(index['ibm']).to include 0
    expect(index['microsoft']).to eq Set.new [2, 3]
  end

  def input
    [{
      'Name' => 'RPG',
      'Type' => 'Compiled, Procedural',
      'Designed by' => 'IBM'
    },
    {
      'Name' => 'Ruby',
      'Type' => 'Imperative, Interpreted, Metaprogramming, Object-oriented class-based, Reflective, Scripting, Interactive mode',
      'Designed by' => 'Yukihiro Matsumoto'
    },
    {
       'Name' => 'Visual Basic',
       'Type' => 'Compiled, Procedural',
       'Designed by' => 'Microsoft'
     },
     {
       'Name' => 'Visual FoxPro',
       'Type' => 'Compiled, Data-oriented, Object-oriented class-based, Procedural',
       'Designed by' => 'Microsoft'
     },
     {
       'Name' => 'BASIC',
       'Type' => 'Imperative, Compiled, Procedural, Interactive mode, Interpreted',
       'Designed by' => 'John George Kemeny, Thomas Eugene Kurtz'
     },
     {
       'Name' => 'Haskell',
       'Type' => 'Compiled, Functional, Metaprogramming, Interpreted, Interactive mode',
       'Designed by' => 'Simon Peyton Jones, Lennart Augustsson, Dave Barton, Brian Boutel, Warren Burton, Joseph Fasel, Kevin Hammond, Ralf Hinze, Paul Hudak, John Hughes, Thomas Johnsson, Mark Jones, John Launchbury, Erik Meijer, John Peterson, Alastair Reid, Colin Runciman, Philip Wadler'
     }]
  end
end
