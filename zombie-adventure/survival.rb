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

survivors = []

player = Player.new

puts "Nobody saw the zombie apocalypse coming, yet here it is..."
puts "You managed to survive the initial outbreak."
puts "You find yourself in a small house with two other survivors."
puts "Would you like to name these survivors?"
input = gets.chomp.downcase
if input == "yes"
  print "Survivor 1: "
  name = gets.chomp
  survivors.push(name)
  print "Survivor 2: "
  name = gets.chomp
  survivors.push(name)
else
  puts "Of course not, they must already have names!"
  2.times do
    survivors.push(["Amelia", "Andrei", "Joel", "Louis", "Bill", "Zoey", "Francis", "Ellie", "Sarah", "Kim"].sample)
  end
end

puts "Let's get started."
puts "Your survivors are: #{survivors}"
