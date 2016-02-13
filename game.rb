require 'pry'
require_relative 'grid'

grid = Grid.new(3, 3)
puts "Number of grid cells: #{grid.cells.length}"

grid.set_cell_alive(4)
puts grid.render_grid

puts grid.print_cell_coordinates(3)
