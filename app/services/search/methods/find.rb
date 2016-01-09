module Search::Methods::Find
  def find(query)
    @words, @antiwords = parse_query(query)
    found_ids = search(@words)
    anti_ids  = search(@antiwords)
    found_ids = found_ids - anti_ids if anti_ids && found_ids
    fetch_resources(found_ids)
  end

  private

  def parse_query(query)
    words = query
            .strip
            .downcase.gsub(/[^\w\s"-]/, '')
            .split(/\s+(?=(?:[^"]*"[^"]*")*[^"]*$)/) # split by \s but not inside "..."
            .reject(&:empty?)
            .map { |s| s.delete('"') }
            .uniq
    words, antiwords = extract_anti_words(words)
    [words, antiwords]
  end

  def extract_anti_words(words)
    antiwords, words = words.partition { |word| antiword?(word) }
    antiwords = antiwords.map { |s| s.delete('-') } # remove thrash symbols
    [words, antiwords]
  end

  def antiword?(word)
    word =~ /\A\-+/
  end

  def search(words)
    results = Set.new
    words.each do |word|
      ids = @index[word]
      results.add(ids) if ids
    end
    results.reduce(&:&) # leave only confluence documents
  end

  def fetch_resources(ids)
    results = Set.new
    ids.each { |id| results.add fetch(id) }
    results
  end
end
