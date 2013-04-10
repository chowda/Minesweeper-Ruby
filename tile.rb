class Tile
  attr_accessor :x, :y, :bomb, :mines_touching

  def initialize(x, y)
    @x = x
    @y = y
    @bomb = false
    @mines_touching = 0
  end
end