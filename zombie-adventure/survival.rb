class Survivor
  def initialize name
    @name = name
    @health = 100
    @weapons = []
    @illness = false
    @hunger = 10
    @thirst = 10
    @scavenging = false
    @days_out = 0
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

  def ration
    @hunger += 1
  end

  def pre_ration
    @hunger -= 1
  end

  def survival_odds(time, chance)
    @time = time
    @survival_odds = chance
  end

  def scav_mission(target)
    @scavenging = true
    @supplies = target
  end

  def away?
    @scavenging
  end

  def mission(base)
    if @time > @days_out
      puts "#{name} has not returned from scavenging yet."
      @days_out += 1
    elsif @survival_odds < (base.danger_level)
      puts "You have a bad feeling that #{name} won't make it back."
      @health = -100
      alive?
      @scavenging = false
      @days_out = 0
    else
      units_found = rand(5..30)
      puts "#{name} has returned from scavenging with #{units_found} #{@supplies}!"
      @scavenging = false
      @days_out = 0
      base.scav_success(@supplies, units_found)
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
    elsif @health == -100
      @death = "something whilst scavenging"
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
    @food = 11
    @water = 10
    @water_supply = true
    @people = 3
    @overcrowded = false
    @building_supplies = 0
    @zombie_activity = "small"
    @danger = 3
  end

  def window_check
    puts "Today the zombie hordes outside are #{@zombie_activity}."
  end

  def zombies_daily_change
    levels = ["eerily quiet", "very small", "quite small", "small", "pretty big", "enormous", "completely filling the streets"]
    @danger = rand(0..(levels.length - 1))
    @zombie_activity = levels[@danger]
  end

  def danger_level
    @danger
  end

  def water?
    @water_supply
  end

  def daily_damage
    damage = @danger*rand(1..2)
    @safety -= damage
  end

  def repair
    puts "Attempting to repair base..."
    if @safety == 100
      puts "Base is already fully repaired."
    elsif @building_supplies > 0
      num = [0.5, 1, 1.5]
      @safety += @building_supplies * num.sample
      puts "Base being repaired!"
      if @safety > 100
        @safety = 100
      end
    else
      puts "You have no building supplies to work with!"
    end
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

  def scav_success(supplies, num)
    case supplies
    when "food"
      @food += num
    when "water"
      @water += num
    when "building supplies"
      @building_supplies += num
    end
  end

  def safe?
    if @safety <= 0
      puts "Zombies broke through to your base!"
      puts "Everyone was killed in the night."
      puts "Game over, hero."
      exit(0)
    end
  end

  def status
    puts case @safety
    when (85..100)
      "The base is very secure."
    when (50..84)
      "The base is fairly secure."
    when (30..49)
      "The base is not very secure."
    when (11..29)
      "The base is vulnerable."
    when (0..10)
      "The base is extremely vulnerable!"
    end

    food_ratio = (@food / @people)
    puts "You have #{@food} portions of food - enough for"
    puts "at least #{food_ratio} days worth of food for you"
    puts "and your #{@people - 1} survivors."
    puts "You have #{@building_supplies} units of building supplies."
    if @water_supply
      puts "Your base is connected to a water supply."
    else
      puts "Your base has to rely on scavenged water."
    end
  end

end

class Hash
  def count_available
    count = 0
    self.each do |x, y|
      if y.away? == false
        count += 1
      end
    end
    count
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
    puts "For example, 'help list' will show you the list of available commands."

  end

  def query question

    case question
    when "rest"
      rest
    when "check status", "check"
      check
    when "build"
      build
    when "list", "list commands", "commands"
      list
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
    puts "The scavenge function will send one survivor out"
    puts "in search of the specified supply.  Use this to"
    puts "your advantage to stay on top of your supplies."
    puts "Currently, they will always return safely."
  end

  def check
    puts "You can use 'check status' to check on your base,"
    puts "yourself or your base.  You can also specify what"
    puts "you want to check.  For example: 'check base status'"
  end

  def explore
    puts "This is when you as the player go out scavenging."
    puts "You'll be presented with your map and the option"
    puts "to choose where you want to explore."
  end

  def list
    commands = ["help", "look outside", "scavenge", "check status",
    "rest", "show map", "explore"].sort
    commands.each do |x|
      puts "-- #{x}"
    end
  end
end


def scavenge(base, map)
  puts "What would you like to scavenge for?"
  input = gets.chomp.downcase
  target = "exit"
  case input
  when "food"
    target = "food"
  when "water"
    if base.water?
      puts "The base has its own water supply."
      scavenge(base, map)
    else
      target = "water"
    end
  when "building supplies", "building materials"
    target = "building supplies"
  when "nevermind", "nothing"
    puts "We'll scavenge later."
  else
    puts "Can't scavenge for '#{input}'."
    puts "If you don't want to scavenge, use 'nevermind'."
    scavenge(base, map)
  end

  if target != "exit"
    survivor_choice

    input = gets.chomp.downcase

    if input == "player" || input == "me"
      explore(map)
    elsif $survivors[input].away?
      puts "That survivor is unavailable."
    elsif $survivors.include?(input)
      puts "Sending #{input.capitalize} to scavenge for #{target}!"
      $survivors[input].scav_mission(target)
      time = rand(2..4)
      death = rand(1..18)
      $survivors[input].survival_odds(time, death)
    else
      puts "There are no survivors by that name."
    end

    puts "What would you like to do now?"

  end

end

def explore(map)
  map.show
  puts "Where would you like to explore?"
end

def survivor_choice

  puts "Which survivor would you like to choose?"

  $survivors.each do |name, person|
    if person.away? == false
      puts "-- #{name.capitalize}"
    end
  end

end

base = Base.new

player = Survivor.new "player"

map = Map.new

help = Info.new

$survivors = {"player" => player}

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
  $survivors[name.downcase] = surv1
  print "Survivor 2: "
  name = gets.chomp
  surv2 = Survivor.new name
  $survivors[name.downcase] = surv2
else
  puts "Right, they must already have names!"
  name = standard.sample
  surv1 = Survivor.new name
  $survivors[name.downcase] = surv1
  standard = standard - name.split(" ")
  name = standard.sample
  surv2 = Survivor.new name
  $survivors[name.downcase] = surv2
end

day = 1

while player.alive? do

  if day > 1

    if ($survivors.count_available > base.food_supply) && (base.food_supply != 0)
      puts "There's not enough food in storage for everyone to eat"
      puts "this morning. As leader, it is your job to ration it out."
      puts "Food portions: #{base.food_supply}     Survivors: #{$survivors.count_available}"
      puts "Who should be the first to eat?"
      $survivors.each do |name, person|
        if person.away?
          puts "-- #{name.capitalize} (unavailable - out scavenging)"
        else
          person.pre_ration
          puts "-- #{name.capitalize}"
        end
      end
      while base.food_supply > 0 do
        input = gets.chomp.downcase
        if $survivors.include?(input) && $survivors[input].away?
          puts "#{input.capitalize} is out scavenging!"
        elsif $survivors.include?(input)
          $survivors[input].ration
          base.eat
          puts "#{input.capitalize} has eaten."
          if base.food_supply > 0
            puts "Who should eat next?"
            puts "Food remaining: #{base.food_supply} portions."
          end
        else
          puts "Who?"
        end
      end
    else
      $survivors.each do |name, person|
        if person.away? == false
          person.supplies_consumed(base)
        end
      end
    end

    $survivors.each do |name, person|

      if person.alive? == false
        puts "#{name.capitalize} has died of #{person.death}!"
        $survivors.delete(name)
      end

    end

  end

  if player.alive? == false
    puts "You died of #{player.death}!  Game over."
    exit(0)
  end

  puts "*"*30
  puts "A new day dawns.  Day #{day}"
  $survivors.each do |name, person|
    if person.away?
      person.mission(base)
    end
  end
  if base.food_supply > 0
    puts "You have #{base.food_supply} portions of food."
    if day == 1
      puts "Each portion will feed one survivor for one day."
    end
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

      break

    when "check window", "look out window", "window", "look at zombies", "look outside", "check outside"
      base.window_check

    when "add food"
      base.test_food_add

    when "build", "repair base", "barricade"
      base.repair

    when "scavenge"
      scavenge(base, map)

    when "explore"
      map.show
      puts "Where would you like to explore?"

    when "show map", "check map", "map", "open map", "display map"

      map.show

    when "help", "help "

      puts "*"*50
      help.main
      puts "*"*50

    when "check base status", "base status"

      base.status

    when "check my status", "my status", "player status", "check player status"

      player.status

    when "check survivor status", "check survivors status", "check survivors' status", "survivors status", "survivors' status", "survivor status"

      survivor_choice

      input = gets.chomp.downcase

      if $survivors.include?(input) && $survivors[input].away?
        puts "#{input.capitalize} is out scavenging!"
      elsif $survivors.include?(input)
        $survivors[input].status
      else
        puts "There are no survivors by that name."
      end

    when "check status", "status"

      puts "Would you like to check the status of your base, yourself, or your survivors?"

      input = gets.chomp.downcase

      case input
      when "base", "home"

        base.status

      when "myself", "me", "self", "player"

        player.status

      when "survivors"

        survivor_choice

        input = gets.chomp.downcase

        if $survivors.include?(input)
          $survivors[input].status
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
  base.zombies_daily_change
  base.safe?
  base.daily_damage

end
