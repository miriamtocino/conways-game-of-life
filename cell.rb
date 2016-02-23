require 'gosu'

class Cell
  attr_accessor :status, :color

  def initialize
    @@colors ||= {
      dead: Gosu::Color::WHITE,
      alive: Gosu::Color::BLACK,
      seed: Gosu::Color::RED
    }
    @@statuses ||= {
      dead: false,
      alive: true
    }

    @color = @@colors[:dead]
    @status = @@statuses[:dead]
  end

  def toggle_status
    if @status == @@statuses[:dead]
      @status = @@statuses[:alive]
    elsif @status == @@statuses[:alive]
      @status = @@statuses[:dead]
    end
  end
end
