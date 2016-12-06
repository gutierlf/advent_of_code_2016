require 'digest'

EXAMPLE_DOOR_ID = 'abc'
ACTUAL_DOOR_ID = 'abbhdwsy'

def add_next_character(state)
  i = state[:i]
  loop do
    hash = Digest::MD5.hexdigest(ACTUAL_DOOR_ID + i.to_s)
    i += 1
    next_char = hash.start_with?('00000') ? hash[5] : nil
    break {password: state[:password] + next_char, i: i} if next_char
  end
end

state = 8.times.inject(password: '', i: 0) do |state|
  add_next_character(state)
end

puts state[:password]
