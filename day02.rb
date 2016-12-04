ROWS = 3
COLUMNS = 3

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
  !top_row?(from) ? from - COLUMNS : from
end

def move_down(from)
  !bottom_row?(from) ? from + COLUMNS : from
end

def move_right(from)
  !right_column?(from) ? from + 1 : from
end

def move_left(from)
  !left_column?(from) ? from - 1 : from
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

code = []
File.readlines('day02_input.txt').inject(5) do |from, line|
  code << line.chars.inject(from) { |from, char| dispatch(char, from) }
  code.last
end
puts code
