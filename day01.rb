def follow_instructions(instructions, initial_state)
  states = []
  instructions.inject(initial_state) do |state, instruction|
    new_bearing = turn(instruction, state[:bearing])
    states += walk_n_blocks(number_of_blocks(instruction), {bearing: new_bearing, coord: state[:coord]})
    states.last
  end
  states
end

def walk_n_blocks(n_blocks, initial_state)
  states = []
  (1..n_blocks).inject(initial_state) do |state|
    states << walk_one_block(state)
    states.last
  end
  states
end

def walk_one_block(state)
  delta = get_coordinate_delta(state[:bearing], 1)
  {bearing: state[:bearing], coord: move_coord_delta(state[:coord], delta)}
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

def calculate_distance(coord)
  coord[:x].abs + coord[:y].abs
end

instructions = File.read('day01_input.txt').split(', ')
states = follow_instructions(instructions, {bearing: 0, coord: {x: 0, y: 0}})
answer_1 = calculate_distance(states.last[:coord])
puts answer_1

coords = states.map { |state| state[:coord] }.unshift({x: 0, y: 0})
duplicate_coord = coords.find { |coord| coords.count(coord) > 1 }
answer_2 = calculate_distance(duplicate_coord)
puts answer_2
