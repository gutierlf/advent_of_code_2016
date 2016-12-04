def valid_triangle?(sides)
  sorted_sides = sides.sort
  (sorted_sides[0] + sorted_sides[1]) > sorted_sides[2]
end

def read_input_numbers
 File.readlines('day03_input.txt')
     .map { |line| line.split.map(&:to_i) }
end

def count_triangles(array_of_array_of_sides)
  array_of_array_of_sides
      .select { |sides| valid_triangle?(sides) }
      .count
end

puts read_input_numbers
         .transpose
         .map { |old_column| count_triangles(old_column.each_slice(3).to_a) }
         .inject(&:+)

