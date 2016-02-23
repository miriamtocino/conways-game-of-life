require 'byebug'
require 'gosu'
require_relative 'cell'

class Grid

  attr_accessor :cells

  def initialize(window, width, height)
    @@window = window
    @@width = width
    @@height = height
    @cells = []

    (@@width * @@height).times do
      @cells << Cell.new
    end
  end

  def draw_grid
    @cells.each_with_index do |cell, index|
      color = Gosu::Color::RED if cell.status == true
      color ||= Gosu::Color::WHITE

      draw_cell(index, color)
    end
  end

  def draw_cell(index, color)
    x, y = get_coordinates(index)

    x1 = 11 + x * 25
    y1 = 11 + y * 25
    x2 = x1 + 24
    y2 = y1
    x3 = x2
    y3 = y2 + 24
    x4 = x1
    y4 = y3

    @@window.draw_quad(x1, y1, color, x2, y2, color, x3, y3, color, x4, y4, color)
  end

  def get_coordinates(index)
    x = index % @@width
    y = index / @@width

    return x, y
  end

  def get_index(x, y)
    return nil if !is_inside_grid?(x, y)
    x + y * @@width
  end

  def get_cell(x, y)
    return nil if !is_inside_grid?(x, y)
    @cells[get_index(x, y)]
  end

  def is_inside_grid?(x, y)
    (x >= 0) && (x < @@width) && (y >= 0) && (y < @@height)
  end

  def get_neighbours(index)
    x, y = get_coordinates(index)
    neighbours = []

    # left-top cell
    neighbours << get_index(x-1, y-1) if is_inside_grid?(x-1, y-1)

    # top cell
    neighbours << get_index(x, y-1) if is_inside_grid?(x, y-1)

    # right-top cell
    neighbours << get_index(x+1, y-1) if is_inside_grid?(x+1, y-1)

    # left cell
    neighbours << get_index(x-1, y) if is_inside_grid?(x-1, y)

    # right cell
    neighbours << get_index(x+1, y) if is_inside_grid?(x+1, y)

    # left-bottom cell
    neighbours << get_index(x-1, y+1) if is_inside_grid?(x-1, y+1)

    # bottom cell
    neighbours << get_index(x, y+1) if is_inside_grid?(x, y+1)

    # right-bottom cell
    neighbours << get_index(x+1, y+1) if is_inside_grid?(x+1, y+1)

    neighbours
  end
end
