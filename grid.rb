require 'pry'
require_relative 'grid_cell'

class Grid
  attr_reader :width, :height, :cells

  def initialize(width, height)
    @width    = width
    @height   = height

    @cells    = []
    (width * height).times do
      @cells << GridCell.new
    end
  end

  def render_grid
    print "\n"

    @cells.each_with_index do |cell, index|
      new_line = (((index + 1) % width) == 0)

      if cell.status == false
        print "-"
      else
        print "x"
      end

      print "\n" if new_line
    end
    print "\n"
    return nil
  end

  def set_cell_alive(index)
    @cells[index].set_alive
  end

  def get_coordinates(index)
    x = index % width
    y = index / width

    return x, y
  end

  def get_index(x, y)
    index = x + y * width
    return index
  end

  def is_inside_grid(x, y)
    (x >= 0) && (x < width) && (y >= 0) && (y < height)
  end
end
