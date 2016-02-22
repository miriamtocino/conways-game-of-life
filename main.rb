require 'gosu'
require_relative 'game'

class Main < Gosu::Window

  def initialize
    width, height = set_width_and_height
    super((width * 25) + 20, (height * 25) + 20)

    self.caption = "Conway's Game Of Life"
    @game = Game.new(self, width, height)
  end

  def draw
    @game.draw
  end

  def set_width_and_height
    puts "Please select the width of your grid:"
    width = gets.chomp.to_i

    puts "Please select the height of your grid:"
    height = gets.chomp.to_i

    return width, height
  end
end

window = Main.new
window.show
