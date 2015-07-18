module Parser
  REGEX_TO_FILE  = %r/(\w+)\s+(\w+)\s+([\d.]+)/
  REGEX_TO_ENTRY = %r/(\w+)\s+(\w+)\s+([\d.]+)\s+([\d.]+)/

  class InvalidInput < StandardError; end

  class << self
    def parse_file(file)
      results = []
      file.each_line do |line|
        results << parse(line, REGEX_TO_FILE).first
      end
      results
    rescue NoMethodError
      raise InvalidInput
    end

    def parse_entry(entry)
      parse(entry, REGEX_TO_ENTRY)
    end

    private
    def parse(line, regex)
      match = line.match regex
      from, to, distance = match[1..3]
      path = Path.new(from: from, to: to, distance: distance)
      return [path, match.to_a.last.to_f]
    rescue NoMethodError
      raise InvalidInput
    end
  end
end
