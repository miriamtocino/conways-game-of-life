require 'byebug'
require_relative 'grid'
require_relative 'cell'

class Game

  def initialize(window, width, height)
    @grid = Grid.new(window, width, height)
  end

  def draw
    @grid.draw_grid
  end

  def handle_mouse_down(x, y)
    y = (y.to_i - 11)/25
    x = (x.to_i - 11)/25

    return nil unless seed_cell = @grid.get_cell(x, y)
    seed_cell.toggle_status
  end

  def tick
    cells = @grid.cells

    cells.each_with_index do |cell, index|
      neighbours = @grid.get_neighbours(index)
      cell.toggle_status if index % 5
    end
  end
end

