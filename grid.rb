require 'byebug'

class Grid
  attr_accessor :cells

  def initialize(width, height)
    @width = width
    @height = height
    @cells = []
  end

  def get_neighbours(index)
    x, y = get_coordinates(index)
    neighbours = []

    # left-top cell
    neighbours << get_cell(x-1, y-1) if is_inside?(x-1, y-1)

    # top cell
    neighbours << get_cell(x, y-1) if is_inside?(x, y-1)

    # right-top cell
    neighbours << get_cell(x+1, y-1) if is_inside?(x+1, y-1)

    # left cell
    neighbours << get_cell(x-1, y) if is_inside?(x-1, y)

    # right cell
    neighbours << get_cell(x+1, y) if is_inside?(x+1, y)

    # left-bottom cell
    neighbours << get_cell(x-1, y+1) if is_inside?(x-1, y+1)

    # bottom cell
    neighbours << get_cell(x, y+1) if is_inside?(x, y+1)

    # right-bottom cell
    neighbours << get_cell(x+1, y+1) if is_inside?(x+1, y+1)

    neighbours
  end

  def get_coordinates(index)
    x = index % @width
    y = index / @width

    return x, y
  end

  def get_index(x, y)
    x + y * @width
  end

  def get_cell(x, y)
    @cells[get_index(x, y)]
  end

  def is_inside?(x, y)
    (x >= 0) && (x < @width) && (y >= 0) && (y < @height)
  end
end
