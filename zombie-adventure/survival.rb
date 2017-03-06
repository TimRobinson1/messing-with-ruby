class Survivor
  def initialize name
    @name = name
    @health = 100
    @weapons = []
    @illness = false
    @hunger = 10
    @thirst = 10
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

    if @hunger < 2
      print "is dying of hunger, "
    elsif @hunger < 4
      print "is starving, "
    elsif @hunger < 8
      print "is pretty hungry, "
    elsif @hunger < 10
      print "is a tad hungry, "
    else
      print "is not hungry, "
    end

    if @thirst < 5
      puts "and is pretty thirsty."
    elsif @thirst < 3
      puts "and is dying of thirst."
    else
      puts "and is not thirsty."
    end
  end

  def supplies_consumed base
    if base.water? == false
      @thirst -= 1
    end

    if base.food?
      base.eat
      if @hunger < 10
        @hunger += 1
      end
    else
      @hunger -= 1
    end

  end

  def test_show
    puts "Hunger: #{@hunger}"
    puts "Thirst: #{@thirst}"
  end

  def alive?
    if @hunger == 0
      @death = "hunger"
      false
    elsif @thirst == 0
      @death = "thirst"
      false
    elsif @health <= 0
      @death = "serious injuries"
      false
    else
      true
    end
  end

  def death
    @death
  end

end

class Base
  def initialize
    @safety = 100
    @food = 10
    @water = 10
    @water_supply = true
    @survivors = 3
    @overcrowded = false
    @building_supplies = 0
    @zombie_activity = "small"
  end

  def window_check
    puts "Today the zombie hordes outside are #{@zombie_activity}."
  end

  def zombies_daily_change
    levels = ["eerily quiet", "very small", "quite small", "small", "pretty big", "enormous", "completely filling the streets"]
    @zombie_activity = levels.sample
  end

  def water?
    @water_supply
  end

  def food?
    if @food <= 0
      false
    else
      true
    end
  end

  def food_supply
    @food
  end

  def eat
    @food -= 1
  end

  def test_show
    puts "Food: #{@food}"
    puts "Water: #{@water}"
  end

  def test_food_add
    @food = 10
  end

  def status
    puts case @safety
    when (85..100)
      "The base is very secure."
    when (50..84)
      "The base is fairly secure."
    when (30..49)
      "The base is not very secure."
    when (1..30)
      "The base is extremely vulnerable."
    end

    food_ratio = @food / @survivors
    puts "You have #{@food} portions of food - enough for"
    puts "at least #{food_ratio} days worth of food for you"
    puts "and your #{@survivors} survivors."
    puts "You have #{@building_supplies} units of building supplies."
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

  def query question

    case question
    when "rest"
      rest
    when "build"
      build
    when "scavenge"
      scavenge
    else
      puts "Unsure what #{question} is referring to."
    end

  end

  def rest
    puts "The rest function will advance time by 1 day."
    puts "At the start of the new day, if there is enough food"
    puts "for everyone, then each survivor will take their share."
    puts "If there is not enough, the responsibilty of rationing it"
    puts "out falls to you."
    puts "Zombie activity will change from day to day."
    puts "Be careful not to rest until you are ready for a new day."
  end

  def build
    puts "not implemented"
  end

  def scavenge
    puts "not implemented"
  end

end

def survivor_choice survivors

  puts "Which survivor?"
  holder = []

  survivors.each do |x, y|
    holder.push(x.capitalize)
  end

  puts "Options: #{holder.join(", ")}"
  input = gets.chomp.downcase

  if survivors.include?(input)
    survivors[input].status
  else
    puts "There are no survivors by that name."
  end

end

survivors = {}

base = Base.new

player = Survivor.new "Player"

map = Map.new

help = Info.new

standard = ["Amelia", "Andrei", "Joel", "Louis", "Bill", "Zoey", "Francis", "Ellie", "Sarah", "Kim"]

puts "Nobody saw the zombie apocalypse coming, yet here it is..."
puts "You managed to survive the initial outbreak."
puts "You find yourself in a small house with two other survivors."
puts "Would you like to name these survivors?"

input = gets.chomp.downcase
if input == "yes"
  print "Survivor 1: "
  name = gets.chomp
  surv1 = Survivor.new name
  survivors[name.downcase] = surv1
  print "Survivor 2: "
  name = gets.chomp
  surv2 = Survivor.new name
  survivors[name.downcase] = surv2
else
  puts "Right, they must already have names!"
  name = standard.sample
  surv1 = Survivor.new name
  survivors[name.downcase] = surv1
  standard = standard - name.split(" ")
  name = standard.sample
  surv2 = Survivor.new name
  survivors[name.downcase] = surv2
end

day = 1

while player.alive? do

  puts "*"*30
  puts "A new day dawns.  Day #{day}"
  if base.food_supply > 0
    puts "You have #{base.food_supply} portions of daily food."
  else
    puts "There's no food left in storage."
  end
  puts "The water supply is still functional."

  if day == 1
    puts "You've set up your base in the small house."
    puts "Through the window you can check on the zombie crowds."
    puts "The other survivors, #{surv1.name} and #{surv2.name}, look to you for guidance."
    puts "Go scavenging (or send others!), check your map, find supplies, "
    puts "barricade your base, rest to end the day. Do whatever you can to survive."
  end

  puts "What would you like to do?"

  while player.alive? do
    input = gets.chomp.downcase

    if (input[0..4] == "help ") && (input.split("").count > 5)

      question = input.split(" ")
      puts "*"*50
      help.query question[1]
      puts "*"*50

    end

    case input

    when "rest"

      puts 'rest'
      break

    when "check window", "look out window", "window", "look at zombies", "look outside", "check outside"
      base.window_check

    when "add food"
      base.test_food_add

    when "show map", "check map", "map", "open map", "display map"

      map.show

    when "help", "help "

      help.main

    when "check base status", "base status"

      base.status

    when "check my status", "my status", "player status", "check player status"

      player.status

    when "check survivor status", "check survivors status", "check survivors' status", "survivors status", "survivors' status", "survivor status"

      survivor_choice(survivors)

    when "check status", "status"

      puts "Would you like to check the status of your base, yourself, or your survivors?"

      input = gets.chomp.downcase

      case input
      when "base", "home"

        base.status

      when "myself", "me", "self", "player"

        player.status

      when "survivors"

        puts "Which survivor?"
        holder = []

        survivors.each do |x, y|
          holder.push(x.capitalize)
        end

        puts "Options: #{holder.join(", ")}"
        input = gets.chomp.downcase

        if survivors.include?(input)
          survivors[input].status
        else
          puts "There are no survivors by that name."
        end

      else
        puts "You cannot check '#{input}'."
      end

    else
      puts "Uncertain what '#{input}' means.  Try 'help'."
    end

  end

  day += 1

  player.supplies_consumed(base)
  surv1.supplies_consumed(base)
  surv2.supplies_consumed(base)

  survivors.each do |name, person|

    if person.alive? == false
      puts "#{name.capitalize} has died of #{person.death}!"
    end

  end

  if player.alive? == false
    puts "You died of #{player.death}!  Game over."
    exit(0)
  end

  player.test_show
  surv1.test_show
  surv2.test_show

  base.zombies_daily_change

end
