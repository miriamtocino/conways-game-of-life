class Cell
  attr_accessor :status, :color

  def initialize(window)
    @@window = window

    @@colors ||= {
      dead: Gosu::Color::WHITE,
      alive: Gosu::Color::BLACK,
    }

    @@statuses ||= {
      dead: false,
      alive: true
    }

    @color = @@colors[:dead]
    @status = @@statuses[:dead]
  end

  def draw(x, y)
    case status
    when @@statuses[:alive]
      color = @@colors[:alive]
    when @@statuses[:dead]
      color = @@colors[:dead]
    end

    x1 = 11 + x * 25
    y1 = 11 + y * 25
    x2 = x1 + 24
    y2 = y1
    x3 = x2
    y3 = y2 + 24
    x4 = x1
    y4 = y3

    @@window.draw_quad(x1, y1, color, x2, y2, color, x3, y3, color, x4, y4, color)
  end

  def set_status(status)
    @status = status
  end

  def toggle_status
    @status = !@status
  end
end
