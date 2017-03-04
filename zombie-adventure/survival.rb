class Survivor
  def initialize name
    @name = name
    @health = 100
    @weapons = []
    @illness = false
    @hunger = 10
    @water = 10
  end

  def alive?
    @health > 0
  end

  def name
    @name
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

player = Survivor.new "Player"

map = Map.new

puts "Nobody saw the zombie apocalypse coming, yet here it is..."
puts "You managed to survive the initial outbreak."
puts "You find yourself in a small house with two other survivors."
puts "Would you like to name these survivors?"

input = gets.chomp.downcase
if input == "yes"
  print "Survivor 1: "
  name = gets.chomp
  survivors.push(name)
  surv1 = Survivor.new name
  print "Survivor 2: "
  name = gets.chomp
  survivors.push(name)
  surv2 = Survivor.new name
else
  puts "Of course not, they must already have names!"
  2.times do
    survivors.push(["Amelia", "Andrei", "Joel", "Louis", "Bill", "Zoey", "Francis", "Ellie", "Sarah", "Kim"].sample)
  end
  surv1 = Survivor.new survivors[0]
  surv2 = Survivor.new survivors[1]
end

puts "*"*30
puts "A new day dawns.  Day 1."
puts "You have 10 portions of daily food."
puts "The water supply is still functional."
puts "You've set up your base in the small house."
puts "Through the window you can check on the zombie crowds."
puts "The other survivors, #{surv1.name} and #{surv2.name}, look to you for guidance."
puts "What do you want to do?"

input = gets.chomp.downcase

show_map = ["show map", "check map", "map", "open map", "display map"]

if show_map.include?(input)
  map.show
elsif input == "help"
  puts "helping!"
elsif input == "check survivor status"
  puts survivors
end
