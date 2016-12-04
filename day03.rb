def valid_triangle?(sides)
  sorted_sides = sides.sort
  (sorted_sides[0] + sorted_sides[1]) > sorted_sides[2]
end

puts File.readlines('day03_input.txt')
         .map { |line| line.split.map(&:to_i) }
         .select { |sides| valid_triangle?(sides) }
         .count
