class Board
  attr_accessor :height, :width, :tiles, :mines

  def initialize(height, width, mines)
    @height = height
    @width = width
    @mines = mines
    @tiles = []

    setup_board
    randomize_mines
    assign_mines_touching
  end

  def print_board
    puts "Board size: #{@height} x #{@width} | Mines: #{@mines}"
    (0...@height).each do |x|
      (0...@width).each do |y|
        if @tiles[x][y].bomb == true
          print " * "
        else
          print " #{@tiles[x][y].mines_touching} "
        end
      end

      puts ''
    end
  end

  private

  def setup_board
    (0...@width).each do |x|
      (0...@height).each do |y|
        @tiles[x] = [] unless @tiles[x]
        @tiles[x][y] = Tile.new(x, y)
      end
    end
  end

  def randomize_mines
    assigned = 0

    while assigned < @mines
      x = rand(@width)
      y = rand(@height)

      tile = @tiles[x][y]
      if tile.bomb == false
        tile.bomb = true
        assigned += 1
      end
    end
  end

  # Find how many neighboring tiles have a bomb and assign the count.
  def assign_mines_touching
    @tiles.flatten.each do |tile|
      neighbors = get_neighbors(tile)
      tile.mines_touching = count_mines_from_neighbors(neighbors)
    end
  end

  # This is a little tricky, and there is probably a better way to do this. Here is what I'm doing.
  # Look for tiles whose position is +/- 1 in every direction from the current tile.
  # Don't collect the current tile.
  def get_neighbors(tile)
    @tiles.flatten.select { |t|
      (t.x <= (tile.x + 1) && t.x >= (tile.x - 1)) &&
      (t.y <= (tile.y + 1) && t.y >= (tile.y - 1)) &&
      tile != t
    }
  end

  # From the neighboring tiles count the number that have a bomb.
  def count_mines_from_neighbors(neighbors)
    neighbors.select{ |n| n.bomb == true }.size
  end

end