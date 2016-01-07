class Search::Resource
  include Search::Methods::Find
  include Search::Methods::Fetch

  def initialize(filename)
    @resource = read_and_parse_json(file: filename)
    @index = Search::Index.new(db: @resource)
  end

  private

  def read_and_parse_json(file:)
    JSON.parse File.read file
  end
end
