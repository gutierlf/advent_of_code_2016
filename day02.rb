keypad = %w(123 456 789)
ROWS = keypad.length
COLUMNS = keypad[0].length

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
  n <= COLUMNS
end

def bottom_row?(n)
  n > COLUMNS * (ROWS - 1)
end

def right_column?(n)
  n % ROWS == 0
end

def left_column?(n)
  n % ROWS == 1
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
File.readlines('day02_input.txt').inject(5) do |from, line|
  code << line.chars.inject(from) { |from, char| dispatch(char, from) }
  code.last
end
puts code
