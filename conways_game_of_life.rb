require 'gosu'
require_relative 'grid'

class ConwaysWayOfLife < Gosu::Window

  def initialize
    puts "Please select the width of your grid:"
    width = gets.chomp.to_i

    puts "Please select the height of your grid:"
    height = gets.chomp.to_i

    super((width * 25) + 20, (height * 25) + 20)
    self.caption = "Conway's Game Of Life"

    @running = false
    @grid = Grid.new(self, width, height)
  end

  def update
    super
    @grid.update if @running
  end

  def draw
    @grid.draw
  end

  def button_down(id)
    case id

    # Select seeds cells by pressing left mouse
    when Gosu::MsLeft
      @grid.handle_mouse_down(mouse_x, mouse_y)

    # Start by pressing enter
    when Gosu::KbReturn
      toggle_running

    # Reset by pressing R
    when Gosu::KbR
      @running = false
      @grid.clear

    # Quit by pressing ESC
    when Gosu::KbEscape
      close
    end
  end

  def toggle_running
    @running = !@running
  end

  def needs_cursor?
    true
  end
end

window = ConwaysWayOfLife.new
window.show
