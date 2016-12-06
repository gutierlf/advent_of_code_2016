def sort_frequencies_hash(hash)
  hash.sort_by { |_key, value| value }
end

def compute_frequencies_hash(str)
  str.scan(/\w/).inject(Hash.new(0)) do |h, c|
    h[c] += 1
    h
  end
end

message = File.readlines('day06_input.txt').map { |line| line.chars[0..-2] }.transpose
              .map { |chars| sort_frequencies_hash(compute_frequencies_hash(chars.join))[0][0] }

puts message.join