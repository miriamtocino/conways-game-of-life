require 'gosu'

class Cell
  @@colors ||= {
    dead: Gosu::Color::WHITE,
    alive: Gosu::Color::BLACK,
  }

  @@statuses ||= {
    dead: false,
    alive: true
  }

  attr_accessor :status, :color

  def initialize
    @color = @@colors[:dead]
    @status = @@statuses[:dead]
  end

  def set_status(status)
    @status = status
  end

  def toggle_status
    if @status == @@statuses[:dead]
      @status = @@statuses[:alive]
    elsif @status == @@statuses[:alive]
      @status = @@statuses[:dead]
    end
  end
end
