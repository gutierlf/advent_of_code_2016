def walk(instructions, initial_state)
  instructions.inject(initial_state) do |state, instruction|
    walk_one(instruction, state)
  end
end

def walk_one(instruction, state)
  new_bearing = turn(instruction, state[:bearing])
  delta = get_coordinate_delta(new_bearing, number_of_blocks(instruction))
  {bearing: new_bearing, coord: move_coord_delta(state[:coord], delta)}
end

def turn(instruction, bearing)
  addend = (direction_to_turn(instruction) == 'R' ? 90 : -90)
  (bearing + addend) % 360
end

def direction_to_turn(instruction)
  instruction[0]
end

def number_of_blocks(instruction)
  instruction[1..-1].to_i
end

def get_coordinate_delta(bearing, n_blocks)
  case bearing
    when 0
      get_vertical_delta(n_blocks)
    when 90
      get_horizontal_delta(n_blocks)
    when 180
      get_vertical_delta(-n_blocks)
    else
      get_horizontal_delta(-n_blocks)
  end
end

def get_vertical_delta(n_blocks)
  {dx: 0, dy: n_blocks}
end

def get_horizontal_delta(n_blocks)
  {dx: n_blocks, dy: 0}
end

def move_coord_delta(coord, delta)
  {x: coord[:x] + delta[:dx], y: coord[:y] + delta[:dy]}
end

def calculate_distance(state)
  state[:coord][:x].abs + state[:coord][:y].abs
end

instructions = File.read('day01_input.txt').split(', ')
state = walk(instructions, {bearing: 0, coord: {x: 0, y: 0}})
answer = calculate_distance(state)
puts answer
