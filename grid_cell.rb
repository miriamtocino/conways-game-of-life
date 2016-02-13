class GridCell
  attr_reader :status

  def initialize
    @status = false
  end

  def set_alive
    @status = true
  end
end
