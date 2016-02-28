require 'gosu'
require_relative 'grid'

class Game

  def initialize(window)
    puts "Grid width:"
    @width = gets.chomp.to_i

    puts "Grid height:"
    @height = gets.chomp.to_i

    @window = window
    @running = false

    @grid = Grid.new(@width, @height)
    (@width * @height).times do
      @grid.cells << false
    end
  end

  def simulation
    return unless @running

    next_generation = []

    @grid.cells.each_with_index do |cell_state, index|
      check_neighbours(next_generation, cell_state, index)
    end

    @grid.cells = next_generation
    sleep 0.5
  end

  def check_neighbours(next_generation, cell_state, index)
    neighbours = @grid.get_neighbours(index)
    live_neighbours = neighbours.count(true)

    if cell_state == true
      if live_neighbours < 2

        # Any live cell with fewer than two live neighbours dies,
        # as if caused by under-population.
        cell_state = false
      elsif live_neighbours == 2 or live_neighbours == 3

        # Any live cell with two or three live neighbours lives on to the next
        # generation.
        cell_state = true
      elsif live_neighbours > 3

        # Any live cell with more than three live neighbours dies,
        # as if by over-population.
        cell_state = false
      end
    elsif cell_state == false and live_neighbours == 3

      # Any dead cell with exactly three live neighbours becomes a live cell,
      # as if by reproduction.
      cell_state = true
    else

      # If none of the above were met, cell dies.
      cell_state = false
    end

    next_generation[index] = cell_state
  end

  def render
    @grid.cells.each_with_index do |state, index|
      x, y = @grid.get_coordinates(index)
      draw_cell(x, y, state)
    end
  end

  def draw_cell(x, y, state)
    case state
    when false
      color = Gosu::Color::WHITE
    when true
      color = Gosu::Color::BLACK
    end

    x1 = 11 + x * 25
    y1 = 11 + y * 25
    x2 = x1 + 24
    y2 = y1
    x3 = x2
    y3 = y2 + 24
    x4 = x1
    y4 = y3

    @window.draw_quad(x1, y1, color, x2, y2, color, x3, y3, color, x4, y4, color)
  end

  def handle_button_down(id, mouse_x, mouse_y)
    case id

    # Select seeds cells by pressing left mouse
    when Gosu::MsLeft
      handle_mouse_down(mouse_x, mouse_y)

    # Start by pressing enter
    when Gosu::KbReturn
      toggle_running

    # Reset by pressing R
    when Gosu::KbR
      @running = false
      clear

    # Quit by pressing ESC
    when Gosu::KbEscape
      @window.close
    end
  end

  def handle_mouse_down(x, y)
    y = (y.to_i - 11)/25
    x = (x.to_i - 11)/25

    return if !@grid.is_inside?(x, y)

    index = @grid.get_index(x, y)
    toggle_state(index)
  end

  def toggle_running
    @running = !@running
  end

  def toggle_state(index)
    @grid.cells[index] = !@grid.cells[index]
  end

  def clear
    @grid.cells.each_with_index do |cell_state, index|
      @grid.cells[index] = false
    end
  end

  def get_width_and_height
    return @width, @height
  end
end
