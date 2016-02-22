require 'byebug'
require 'gosu'
require_relative 'grid_cell'

class Grid

  def initialize(window, width, height)
    @@window = window
    @@width = width
    @@height = height
    @cells = []

    (@@width * @@height).times do
      @cells << GridCell.new
    end
  end

  def draw_grid
    @cells.each_with_index do |cell, index|
      draw_cell(index)
    end
  end

  def draw_cell(index)
    x, y = get_coordinates(index)

    x1 = 11 + x * 25
    y1 = 11 + y * 25
    x2 = x1 + 24
    y2 = y1
    x3 = x2
    y3 = y2 + 24
    x4 = x1
    y4 = y3

    c = Gosu::Color.argb(0xff_ffffff)

    @@window.draw_quad(x1, y1, c, x2, y2, c, x3, y3, c, x4, y4, c, 2)
  end

  def set_alive(index)
    @cells[index].set_alive
  end

  def get_coordinates(index)
    x = index % @@width
    y = index / @@width

    return x, y
  end

  def get_index(x, y)
    if !is_inside_grid(x, y)
      return nil
    else
      return x + y * @@width
    end
  end

  def is_inside_grid(x, y)
    (x >= 0) && (x < @@width) && (y >= 0) && (y < @@height)
  end

  def get_neighbours(index)
    x, y = get_coordinates(index)

    neighbours = []

    # left-top cell
    neighbours << get_index(x-1, y-1) if is_inside_grid(x-1, y-1)

    # top cell
    neighbours << get_index(x, y-1) if is_inside_grid(x, y-1)

    # right-top cell
    neighbours << get_index(x+1, y-1) if is_inside_grid(x+1, y-1)

    # left cell
    neighbours << get_index(x-1, y) if is_inside_grid(x-1, y)

    # right cell
    neighbours << get_index(x+1, y) if is_inside_grid(x+1, y)

    # left-bottom cell
    neighbours << get_index(x-1, y+1) if is_inside_grid(x-1, y+1)

    # bottom cell
    neighbours << get_index(x, y+1) if is_inside_grid(x, y+1)

    # right-bottom cell
    neighbours << get_index(x+1, y+1) if is_inside_grid(x+1, y+1)

    neighbours
  end
end
