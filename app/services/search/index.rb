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
    list = str.split(/\s*,\s*/).map(&:downcase)
    # ["john george kemeny", "thomas eugene kurtz"]
    list += make_one_word(list) + make_word_levels(list)
    list.uniq
    # ["john george kemeny", "thomas eugene kurtz", "john", "george", "kemeny"]
  end

  def make_one_word(list)
    list.map { |item| item.split(/\s+/) }.flatten
  end

  def make_word_levels(list)
    # ["john george kemeny", "thomas eugene kurtz"]
    list
      .map { |item| item.split(/\s+/) }       # split to words
      .map { |item| make_combi([], item, 1) } # make words combination 0...n.join(' ')
      .flatten                                # flat array
      .reject(&:nil?)                         # drop nil values
    # ["john george", "thomas eugene"]
  end

  def make_combi(set, list, i)
    return if list.count <= 1 || i >= list.count - 1
    set << list[0..i].join(' ')
    set << make_combi(set, list, i + 1)
    set.flatten
  end
end
