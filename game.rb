require 'byebug'
require_relative 'grid'

class Game

  def initialize(window)
    @grid = Grid.new(window, 6, 6)
  end

  def draw
    @grid.draw_grid
  end

  def print_intro
    puts "Welcome to Conway's Game of Life"
  end

  def set_width_and_height
    puts "Please select the width of your grid:"
    width = gets.chomp.to_i

    puts "Please select the height of your grid:"
    height = gets.chomp.to_i

    return width, height
  end

  def set_initial_cells_alive
    answer = 'Start'

    while !answer.empty?
      puts 'Set index: (Or type enter to continue)'

      answer = gets.chomp
      next if answer.empty?

      index = answer.to_i
      x, y = @grid.get_coordinates(index)

      if @grid.is_inside_grid(x, y)
        @grid.set_alive(index)
      else
        puts 'That index is not inside the grid. Try again.'
        next
      end

      @grid.render_grid
    end
  end
end

