require 'byebug'
require_relative 'grid'
require_relative 'cell'

class Game

  attr_accessor :grid

  def initialize(window, width, height)
    @grid = Grid.new(window, width, height)
  end

end
