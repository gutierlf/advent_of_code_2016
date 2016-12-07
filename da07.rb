HYPERNET_REGEX = /\[[a-z]*\]/

def supports_tls?(address)
  no_hypernet_abba?(address) && any_segment_abba?(address)
end

def no_hypernet_abba?(address)
  !any_abba?(address.scan(HYPERNET_REGEX))
end

def any_segment_abba?(address)
  any_abba?(address.split(HYPERNET_REGEX))
end

def any_abba?(strings)
  strings.map { |segment| has_abba?(segment) }.any?
end

def has_abba?(segment)
  abba_regex = /([a-z])([a-z])\2\1/
  segment.scan(abba_regex).select { |a, b| a != b }.any?
end

answer = File.readlines('day07_input.txt').select { |address| supports_tls?(address) }.count
puts answer