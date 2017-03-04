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

  def status
    print "#{@name} has #{@health} health, "
    if @weapons == []
      print "has no weapons, "
    else
      print "has a #{weapons} as a weapon, "
    end

    if @illness
      print "is looking rather pale, "
    else
      print "is looking healthy, "
    end

    if @hunger < 5
      print "is pretty hungry, "
    elsif @hunger < 3
      print "is starving, "
    else
      print "is not hungry, "
    end

    if @water < 5
      puts "and is pretty thirsty."
    elsif @water < 3
      puts "and is dying of thirst."
    else
      puts "and is not thirsty."
    end

  end

end

class Base
  def initialize
    @safety = 100
    @food = 10
    @water_supply = true
    @survivors = 3
    @overcrowded = false
  end

  def status
    n = @safety
    puts case n
    when (85..100)
      "The base is very secure."
    when (50..84)
      "The base is fairly secure."
    when (30..49)
      "The base is not very secure."
    when (1..30)
      "The base is extremely vulnerable."
    end
    n = @food
    food_ratio = @food / @survivors
    puts "You have #{@food} portions of food - enough for"
    puts "at least #{food_ratio} days worth of food for you"
    puts "and your #{@survivors} survivors."
    if @water_supply
      puts "Your base is connected to a water supply."
    else
      puts "Your base has to rely on scavenged water."
    end
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
    puts "You've got a map of the town and marked out 9 areas
that are potentially of interest.  Areas of interest that
you've searched are marked with an 'X'"
  end

  def visit choice
    @map.gsub! choice.to_s, "X"
  end

end

class Info

  def main

    puts "Each day in the zombie apocalypse is a fight for survival."
    puts "Keep an eye on your food and water supplies and make sure you"
    puts "have enough for everybody at the start of each day."
    puts "Try 'scavenge', 'build', 'check status' or 'rest'"
    puts "Use help <query> for more information."

  end

end

survivors = []

base = Base.new

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
puts "Go scavenging (or send others!), check your map, find supplies,
barricade your base, rest to end the day. Do whatever you can to survive."
puts "What would you like to do?"

input = gets.chomp.downcase


show_map = ["show map", "check map", "map", "open map", "display map"]

help = Info.new

if show_map.include?(input)
  map.show
elsif input == "help"
  help.main
elsif input == "check status"
  puts "Would you like to check the status of your base, yourself, or your survivors?"
  input = gets.chomp.downcase
  if input == "base"
    base.status
  elsif input == "self" || input == "myself"
    player.status
  elsif input == "survivors"
    puts "SURVIVORS"
  else
    puts "no idea"
  end
end
