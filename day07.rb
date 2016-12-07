HYPERNET_REGEX = /\[[a-z]*\]/

def supports_ssl?(address)
  get_supernet_abas(address).map do |aba|
    any_bab?(address.scan(HYPERNET_REGEX), get_bab_from(aba))
  end.any?
end

def get_supernet_abas(address)
  address.split(HYPERNET_REGEX)
      .map { |segment| get_segment_abas(segment) }
      .flatten
end

def get_segment_abas(segment)
  aba_regex = /(?=(([a-z])[a-z]\2))/
  segment.scan(aba_regex).map(&:first)
end

def get_bab_from(aba)
  aba.chars.values_at(1, 0, 1).join
end

def any_bab?(segments, bab)
  segments.map { |segment| segment[bab] }.any?
end

def supports_tls?(address)
  no_hypernet_abba?(address) && any_segment_abba?(address)
end

def no_hypernet_abba?(address)
  !any_abba?(address.scan(HYPERNET_REGEX))
end

def any_segment_abba?(address)
  any_abba?(address.split(HYPERNET_REGEX))
end

def any_abba?(segments)
  segments.map { |segment| has_abba?(segment) }.any?
end

def has_abba?(segment)
  abba_regex = /([a-z])([a-z])\2\1/
  segment.scan(abba_regex).select { |a, b| a != b }.any?
end

addresses = File.readlines('day07_input.txt')
answer_tls = addresses.select { |address| supports_tls?(address) }.count
puts answer_tls

answer_ssl = addresses.select { |address| supports_ssl?(address) }.count
puts answer_ssl