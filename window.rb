require 'gosu'
require_relative 'conways_game_of_life'

class Window < Gosu::Window

  def initialize
    @game = ConwaysGameOfLife.new(self)
    width, height = @game.get_width_and_height

    super((width * 25) + 20, (height * 25) + 20)
    self.caption = "Conway's Game Of Life"
  end

  def update
    super
    @game.simulation
  end

  def draw
    @game.render
  end

  def button_down(id)
    @game.handle_button_down(id, mouse_x, mouse_y)
  end

  def needs_cursor?
    true
  end
end

window = Window.new
window.show
