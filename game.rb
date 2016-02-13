require 'byebug'
require_relative 'grid'

grid = Grid.new(3, 3)
puts "Number of grid cells: #{grid.cells.length}"
