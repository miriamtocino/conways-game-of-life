require 'gosu'
require_relative 'cell'

class Grid

  def initialize(window, width, height)
    @@window = window
    @@width = width
    @@height = height

    @cells = []

    (@@width * @@height).times do
      @cells << Cell.new(@@window)
    end
  end

  def update
    next_cells = []

    @cells.each_with_index do |cell, index|
      check_neighbour_status(next_cells, cell, index)
    end

    @cells = next_cells
    sleep 0.7
  end

  def draw
    @cells.each_with_index do |cell, index|
      x, y = get_coordinates(index)
      cell.draw(x, y)
    end
  end

  def handle_mouse_down(x, y)
    y = (y.to_i - 11)/25
    x = (x.to_i - 11)/25

    return if !is_inside_grid?(x, y)
    get_cell(x, y).toggle_status
  end

  def clear
    @cells.each do |cell|
      cell.set_status(false)
    end
  end

  private

  def check_neighbour_status(next_cells, cell, index)
    neighbours = get_neighbour_cells(index)
    status_neighbours = neighbours.map(&:status)
    alive_neighbours_count = status_neighbours.count(true)

    if cell.status == true
      if alive_neighbours_count < 2

        # Any live cell with fewer than two live neighbours dies,
        # as if caused by under-population.
        status = false
      elsif alive_neighbours_count == 2 or alive_neighbours_count == 3

        # Any live cell with two or three live neighbours lives on to the next
        # generation.
        status = true
      elsif alive_neighbours_count > 3

        # Any live cell with more than three live neighbours dies,
        # as if by over-population.
        status = false
      end
    elsif cell.status == false and alive_neighbours_count == 3

      # Any dead cell with exactly three live neighbours becomes a live cell,
      # as if by reproduction.
      status = true
    else

      # If none of the above were met, cell dies.
      status = false
    end

    next_cells[index] = Cell.new(@@window)
    next_cells[index].set_status(status)
  end


  def get_neighbour_cells(index)
    x, y = get_coordinates(index)
    neighbours = []

    # left-top cell
    neighbours << get_cell(x-1, y-1) if is_inside_grid?(x-1, y-1)

    # top cell
    neighbours << get_cell(x, y-1) if is_inside_grid?(x, y-1)

    # right-top cell
    neighbours << get_cell(x+1, y-1) if is_inside_grid?(x+1, y-1)

    # left cell
    neighbours << get_cell(x-1, y) if is_inside_grid?(x-1, y)

    # right cell
    neighbours << get_cell(x+1, y) if is_inside_grid?(x+1, y)

    # left-bottom cell
    neighbours << get_cell(x-1, y+1) if is_inside_grid?(x-1, y+1)

    # bottom cell
    neighbours << get_cell(x, y+1) if is_inside_grid?(x, y+1)

    # right-bottom cell
    neighbours << get_cell(x+1, y+1) if is_inside_grid?(x+1, y+1)

    neighbours
  end

  def get_coordinates(index)
    x = index % @@width
    y = index / @@width

    return x, y
  end

  def get_index(x, y)
    x + y * @@width
  end

  def get_cell(x, y)
    @cells[get_index(x, y)]
  end

  def is_inside_grid?(x, y)
    (x >= 0) && (x < @@width) && (y >= 0) && (y < @@height)
  end
end
