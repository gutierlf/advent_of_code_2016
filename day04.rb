ROOM_REGEX = /([a-z\-]*)(\d*)\[(.....)\]/

def parse_room(encrypted_name)
  name, id_str, checksum = encrypted_name.scan(ROOM_REGEX)[0]
  {name: name, id: id_str.to_i, checksum: checksum}
end

def valid_room?(room)
  compute_checksum(room[:name]) == room[:checksum]
end

def compute_checksum(name)
  swap_frequencies_hash(compute_frequencies_hash(name))
      .sort
      .reverse
      .map { |swapped_pair| swapped_pair[1].chars.sort }
      .join('')
      .delete('-')[0..4]
end

def swap_frequencies_hash(hash)
  hash.inject(Hash.new('')) do |swapped, freq_pair|
    swapped[freq_pair[1]] += freq_pair[0]
    swapped
  end
end

def compute_frequencies_hash(name)
  name.scan(/\w/).inject(Hash.new(0)) do |h, c|
    h[c] += 1
    h
  end
end

answer = File.readlines('day04_input.txt')
             .map { |encrypted_name| parse_room(encrypted_name) }
             .select { |room| valid_room?(room) }
             .map { |room| room[:id] }
             .inject(&:+)

puts answer
