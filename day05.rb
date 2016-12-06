require 'digest'

EXAMPLE_DOOR_ID = 'abc'
ACTUAL_DOOR_ID = 'abbhdwsy'

def interesting?(hash)
  hash.start_with?('00000') && hash[5] =~ /[0-7]/
end

def add_next_character(state)
  password = state[:password]
  i = state[:i]
  loop do
    hash = Digest::MD5.hexdigest(ACTUAL_DOOR_ID + i.to_s)
    i += 1
    index = interesting?(hash) ? hash[5].to_i : nil
    if index && password[index].empty?
      password[index] = hash[6]
      break {password: password, i: i}
    end
  end
end

state = 8.times.inject(password: ([''] * 8), i: 0) do |state|
  add_next_character(state)
end

puts state[:password].join
