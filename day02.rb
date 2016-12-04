INVALID_KEY = '0'
KEYPAD = %w(00100 02340 56789 0ABC0 00D00)
KEYS = KEYPAD.join('')
ROWS = KEYPAD.length
COLUMNS = KEYPAD[0].length

def valid_key_for?(index)
  get_key_for(index) != INVALID_KEY
end

def get_index_for(key)
  KEYS.index(key.to_s)
end

def get_key_for(index)
  KEYS[index]
end

def dispatch(char, index)
  case char
  when 'U' then move_up(index)
  when 'D' then move_down(index)
  when 'L' then move_left(index)
  when 'R' then move_right(index)
  else index
  end
end

def move_up(index)
  can_move_up?(index) ? move_up!(index) : index
end

def move_down(index)
  can_move_down?(index) ? move_down!(index) : index
end

def move_right(index)
  can_move_right?(index) ? move_right!(index) : index
end

def move_left(index)
  can_move_left?(index) ? move_left!(index) : index
end

def can_move_up?(index)
  !top_row?(index) && valid_key_for?(move_up!(index))
end

def can_move_down?(index)
  !bottom_row?(index) && valid_key_for?(move_down!(index))
end

def can_move_right?(index)
  !right_column?(index) && valid_key_for?(move_right!(index))
end

def can_move_left?(index)
  !left_column?(index) && valid_key_for?(move_left!(index))
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

def move_up!(index)
  index - COLUMNS
end

def move_down!(index)
  index + COLUMNS
end

def move_right!(index)
  index + 1
end

def move_left!(index)
  index - 1
end

code = []
File.readlines('day02_input.txt').inject(get_index_for(5)) do |index, line|
  code << line.chars.inject(index) { |index, char| dispatch(char, index) }
  code.last
end
puts code.map { |index| get_key_for(index) }
