KEYPAD = %w(123 456 789)
KEYS = KEYPAD.join('')
ROWS = KEYPAD.length
COLUMNS = KEYPAD[0].length

def get_index_for(key)
  KEYS.index(key.to_s)
end

def get_key_for(index)
  KEYS[index].to_i
end

def dispatch(char, from)
  case char
  when 'U' then move_up(from)
  when 'D' then move_down(from)
  when 'L' then move_left(from)
  when 'R' then move_right(from)
  else from
  end
end

def move_up(from)
  can_move_up?(from) ? move_up!(from) : from
end

def move_down(from)
  can_move_down?(from) ? move_down!(from) : from
end

def move_right(from)
  can_move_right?(from) ? move_right!(from) : from
end

def move_left(from)
  can_move_left?(from) ? move_left!(from) : from
end

def can_move_up?(from)
  !top_row?(from)
end

def can_move_down?(from)
  !bottom_row?(from)
end

def can_move_right?(from)
  !right_column?(from)
end

def can_move_left?(from)
  !left_column?(from)
end

def top_row?(n)
  n < COLUMNS
end

def bottom_row?(n)
  n > COLUMNS * (ROWS - 1) - 1
end

def right_column?(n)
  n % COLUMNS == COLUMNS - 1
end

def left_column?(n)
  n % COLUMNS == 0
end

def move_up!(from)
  from - COLUMNS
end

def move_down!(from)
  from + COLUMNS
end

def move_right!(from)
  from + 1
end

def move_left!(from)
  from - 1
end

code = []
File.readlines('day02_input.txt').inject(get_index_for(5)) do |from, line|
  code << line.chars.inject(from) { |from, char| dispatch(char, from) }
  code.last
end
puts code.map { |index| get_key_for(index) }
