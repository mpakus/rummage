class Search::Index
  def initialize(db:)
    @index = {}
    db.each_with_index do |item, id|
      parse(key: 'Name', item: item, id: id)
      parse(key: 'Type', item: item, id: id)
      parse(key: 'Designed by', item: item, id: id)
    end
  end

  def fetch
    @index
  end

  private

  def parse(key:, item:, id:)
    fetch_names(item[key]).each do |name|
      @index[name] = @index.fetch(name, Set.new) << id
    end
  end

  def fetch_names(str)
    return [] unless str
    # "John George Kemeny, Thomas Eugene Kurtz"
    list = str.split(/\s*\,\s*/).map{ |item| item.downcase }
    # ["john george kemeny", "thomas eugene kurtz"]
    list + list.map{ |item| item.split(/\s+/) }.first
    # ["john george kemeny", "thomas eugene kurtz", "john", "george", "kemeny"]
  end
end
