require 'gosu'
require_relative 'game'

class ConwaysWayOfLife < Gosu::Window

  def initialize
    @width, @height = set_width_and_height
    super((@width * 25) + 20, (@height * 25) + 20)

    self.caption = "Conway's Game Of Life"
    @game = Game.new(self, @width, @height)
  end

  def draw
    @game.draw
  end

  def update
  end

  def set_width_and_height
    puts "Please select the width of your grid:"
    width = gets.chomp.to_i

    puts "Please select the height of your grid:"
    height = gets.chomp.to_i

    return width, height
  end

  def needs_cursor?
    true
  end

  def button_down(id)
    # Select seeds celss by pressing left mouse
    if id == Gosu::MsLeft
      @game.handle_mouse_down(mouse_x, mouse_y)
    end

    # Reset game by pressing Ctrl-R
    if id == Gosu::KbR && button_down?(Gosu::KbLeftControl)
      @game = Game.new(self, @width, @height)
    end

    # Start game by pressing enter
    if id == Gosu::KbReturn
      @game.tick
    end
  end
end

window = ConwaysWayOfLife.new
window.show
