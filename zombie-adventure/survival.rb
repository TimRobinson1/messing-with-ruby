class Player
  def initialize
    @health = 100
    @weapons = []
    @illness = false
    @hunger = 10
    @water = 10
  end

  def alive?
    @health > 0
  end
end

class Base
  def initialize
    @safety = 100
    @food = 10
    @water_access = true
    @overcrowded = false
  end
end

class Map
  def initialize
    @map = "\n    .....[1][2]..[3]
    ................
    .........[4]....
    ................
    [5]..[BASE]..[6]
    ................
    ...[7]..........
    ................
    ......[8]..[9]..\n "
    @initial_map = @map
  end

  def show
    puts @map
  end

  def visit choice
    @map.gsub! choice.to_s, "X"
  end


end

survivors = []

player = Player.new

map = Map.new

map.visit 2

map.show
