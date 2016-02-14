require 'gosu'
require_relative 'game'

class Main < Gosu::Window
  def initialize
    super(640, 640)
    self.caption = "Conway's Game Of Life"
    @game = Game.new(self)
  end

  def draw
    @game.draw
  end
end

window = Main.new
window.show
