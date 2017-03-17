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
    @scav_ready = true
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

  def ready?
    @scav_ready
  end

  def tired
    @scav_ready = false
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
    elsif @survival_odds < (base.danger_level * 2)
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
    @food = 30
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
    when "medicine"
      # medicine
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
    @visitable = ("1".."9").to_a
  end

  def show
    puts @map
    puts "You've got a map of the town and marked out 9 areas
that are potentially of interest.  Areas of interest that
you've searched are marked with an 'X'"
  end

  def visit choice
    if @visitable.include?(choice)
      @map.gsub! choice.to_s, "X"
      @visitable -= [choice]
      true
    else
      puts "That's not an available location."
      false
    end
  end

end

class Explore
  def initialize
    @location = ["warehouse", "pharmacy", "cinema", "hardware store",
      "farmhouse", "hospital", "grocery store", "police station", "office"].sample
    @description = ["dilapidated", "rundown", "badly damaged", "slightly flooded",
    "crumbling", "rickety and dark", "dark, rotting", "mostly intact", "seemingly abandoned"].sample
    case @location
    when "pharmacy", "hospital"
      @loot = "medicine"
    when "hardware store", "warehouse"
      @loot = "building supplies"
    when "grocery store"
      @loot = "food"
    else
      @loot = ["food", "building supplies"].sample
    end
    @loot_amount = rand(6..23)
    @enemy = ["zombies milling about", "strange noises and whispers",
      "hostile survivors setting up a base"].sample
  end

  def encounter
    puts "You approach the point of interest on the map, to find a"
    puts "#{@description} #{@location}. Looking around, you reckon you can salvage"
    puts "at least #{@loot_amount} #{@loot}, but there are #{@enemy}"
    puts "in the building. What do you do?"
    options
  end

  def options
    puts "-- leave"
    puts "-- use stealth"
    if @enemy == "hostile survivors setting up a base"
      puts "-- fight survivors"
      puts "-- try to negotiate"
    elsif @enemy == "strange noises and whispers"
      puts "-- investigate noises"
    else
      puts "-- fight zombies"
    end

    input = gets.chomp.downcase
    case input
    when "leave", "flee"
      puts "You slip out quietly and head back to base."
      puts "You make it back to base empty handed. Now what?"
    when "use stealth", "stealth", "sneak"
      sneak
    when "fight survivors"
      human_combat
    when "try to negotiate", "negotiate"
      negotiate
    when "investigate noises"
      investigate
    when "fight zombies"
      zombie_combat
    else
      puts "Not sure what '#{input}' means, try typing one of the suggestions."
      options
    end
  end

  def negotiate
    chance = rand(1..3)
    if chance == 3
      puts "The survivors co-operate, and offer you a fair portion of their supplies"
      puts "in exchange for allowing them to copy down your map of the area."
      puts "You agree, and leave in peace with some supplies."
      @loot = @loot / 3
    else
      puts "You put your hands up and attempt to negotiate with the survivors."
      puts "It becomes very clear - very quickly - that they're not willing to talk."
      puts "You flee, barely escaping with your life."
      puts "You return to base empty-handed."
    end
  end

  def zombie_combat
    # Will add possibility of zombie bites and infections at a later date!
    puts "You decide to take on the zombies inside the #{@location}."
    chance = rand(1..10)
    if chance <= 6
      puts "Luckily, they seem pretty dazed and thinly spread. You make"
      puts "short work of them, leaving the #{@location} free for you to"
      puts "scavenge safely."
      success
    elsif chance <= 9
      puts "Unfortunately, the zombies here seem to be recently infected,"
      puts "so they're a little sharper than usual. As you hack and slash"
      puts "your way through the hordes, more and more keep coming, and"
      puts "you eventually have to cut your losses and run empty-handed."
    else
      puts "Unfortunately, the zombies here seem to be recently infected,"
      puts "and they're relentless. Barely escaping with your life as the"
      puts "hordes begin to overwhelm you, you manage to escape with just"
      puts "a few large gashes down your forearm. And... are those"
      puts "teeth marks...?"
      puts "*** Infection not yet implemented ***"
    end
  end

  def human_combat
    puts "You decide that these survivors aren't going to co-operate."
    chance = (1..5)
    case chance
    when 1
      puts "Although they've taken over the #{@location}, you reckon you can"
      puts "take them on. You snatch an enormous hammer from the ground and"
      puts "begin working your way through the building. You smash skull"
      puts "after skull, after skull. With surprising ease, you clear out the"
      puts "entire #{@location}. It's only after you've cracked the final survivor's"
      puts "skull, with brain matter over your top, that you consider that they may"
      puts "not have been hostile after all. You shake the thought from your head,"
      puts "and drop the bloodied hammer by the fresh corpse. You start scavenging."
      success
    when 2
      puts "Although they've taken over the #{@location}, you reckon you can"
      puts "take them on. You snatch an enormous hammer from the ground and"
      puts "begin fighting your way through the building. Dodging bullets and"
      puts "angrily thrusted knives, you manage to clear the #{@location} of"
      puts "life. Satisfied that they're all gone, you begin to scavenge."
      success
    when 3
      puts "They're swarming all over the #{@location}. You do your best to kick,"
      puts "punch, scrape, slash and shoot your way through, but to no avail."
      puts "With too many enemies to face, you're forced to flee."
    when 4
      puts "As soon as you decide this, you're proved correct when a survivor bellows"
      puts "and begins pouring down bullets at you. You dive behind cover, just barely"
      puts "escaping the stream of gun shots. At your first opportunity, you dash for"
      puts "the exit. No way you can deal with that level of firepower."
    else
      puts "As soon as you decide this, you're proved correct when a survivor bellows"
      puts "and begins pouring down bullets at you. You dive behind cover, but you're"
      puts "clipped straight through your right leg by a stray bullet. You pass out"
      puts "from a mix of pain and fear. Who knows what happened to you, because you"
      puts "never woke up after that."
      puts "Dead! Game over."
    end
  end


  def sneak
    if @enemy == "strange noises and whispers"
      puts "You wander around the building cautiously, still hearing"
      puts "the strange noises. After several minutes of slow, quiet"
      puts "searching, you decide you've got enough and leave, the mystery"
      puts "of the strange noises forgotten behind you."
      success
    elsif @enemy == "zombies milling about"
      puts "Zombies are stupid and slow. With that in mind, you hope that they"
      puts "won't notice you as you move around gathering supplies."
      chance = rand(1..3)
      case chance
      when 1
        puts "You're correct in your thinking and manage to scavenge all that"
        puts "you can find without any of the zombies noticing you."
        success
      when 2
        puts "The zombies are quite numerous, and soon catch on that you're"
        puts "skulking around. They begin to follow you and start blocking your"
        puts "path. You're forced to leave with much less than was available, before"
        puts "too many zombies join the hunt."
        @loot_amount = @loot_amount / 2
      else
        puts "You were completely wrong. These zombies were all too aware of your"
        puts "presence and didn't hesitate to start forming a horde to hunt you down."
        puts "With the infected numbers swelling hugely, you're forced to leave with nothing."
      end
    else
      chance = rand(1..4)
      if chance == 4
        puts "You manage to completely avoid contact with the hostile survivors,"
        puts "and you're extremely chuffed with how much you've been able to steal"
        puts "right under their noses. Still undetected, you make your escape."
        success
      else
        puts "There are too many survivors wandering around, and before you can"
        puts "find anything useful, you're spotted. As the deranged survivor screams"
        puts "and points his gun at you, you're forced to flee empty-handed."
      end
    end
  end

  def investigate
    chance = rand(1..100)
    if chance == 1
      puts "You follow the noises through the dark corridors."
      puts "Eventually you track them to a small, cramped room."
      puts "Without warning, the noises turn to loud groans and a"
      puts "zombie sinks his teeth into your jugular from behind."
      puts "You sink to your knees, clutching your neck."
      puts "Dead."
      exit(0)
    elsif chance < 50
      puts "You wander around aimlessly, unable to locate the source"
      puts "of the strange noises. After several minutes of fruitless"
      puts "searching, you give up and start scavenging supplies."
      success
    elsif chance < 70
      puts "You manage to track the noises to a shoddily barricaded room"
      puts "where a survivor is pacing back and forth. They're unsure of"
      puts "you at first, but you persuade them that you're not a threat."
      puts "They ask to join you, in exchange for the building's supplies."
      puts "Yes, or no?"
      if (input = gets.chomp.downcase) == "yes"
        puts "You nod and they join you in scavenging the building."
        name = "Steve"
        surv3 = Survivor.new name
        $survivors[name.downcase] = surv3
        success
      elsif input == "no"
        puts "You decline the survivor's offer and they're immediately hostile."
        puts "They threaten you to leave the building."
        puts "-- leave"
        puts "-- fight"
        if (input = gets.chomp) == "leave"
          puts "You leave quietly, and return to base empty handed."
        elsif input == "fight"
          odds = rand(1..10)
          if odds == 1
            puts "The survivor senses your aggression, overpowers you, and snaps your neck."
            puts "Dead."
            exit(0)
          else
            puts "You pounce on them before they can fight back, killing them quickly."
            puts "You set out to scavenge the rest of the building."
            success
          end
        else
          puts "Unsure as to the best thing to do, you leave them alone."
          puts "You may not have gained any supplies, but at least no human blood was shed."
        end
      else
        puts "The survivor is startled by a noise in an adjacent room and runs away."
        puts "Seconds later, you hear many people shouting and gunshots."
        puts "Fearing for your life, you flee from the scene empty handed."
      end
    elsif chance < 80
      puts "You follow the whispers to a glowing red room with some kind of"
      puts "bizarre shrine. You're certain that the whispering is comiing from"
      puts "the room but there's no one in there."
      puts "Determined to be brave, you shut the door to the room with a shiver"
      puts "running down your spine, and begin searching the rest of the building."
      success
    elsif chance < 85
      puts "You follow the strange noises until it nearly leads you into a room"
      puts "packed with shambling zombies. You pause, and manage to close the door"
      puts "before they notice you. You proceed to loot the rest of the building."
      success
    elsif chance <= 97
      puts "The noise seems to be coming from a hissing radio. It crackles and hisses"
      puts "with bursts of static, before suddenly exclaiming 'The end of times are here,"
      puts "and we all must accept our fates. There is no escape. This is the story of how"
      puts "you died.' You stare at the radio for several seconds before you realise that"
      puts "the battery has been ripped out of the back."
      puts "Utterly confused, you hasten to explore the building and get out quickly."
      success
    else
      puts "You follow the noises into a small room, where there's a scruffy"
      puts "looking dog! He pants happily when he sees you, as if he can tell"
      puts "that you're not infected. It looks like he's going to follow you,"
      puts "like it or not!"
      print "Name the dog: "
      input = gets.chomp
      dog = Survivor.new input
      $survivors[input.downcase] = dog
      success
    end
  end

  def success
    puts "You manage to return to your base with #{@loot_amount} #{@loot}!"
    $spoils = [@loot_amount, @loot]
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
    puts "Using the build function currently allows you to repair"
    puts "the base against zombie damage.  Zombie damage occurs daily"
    puts "depending on the level of activity outside."
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
    "rest", "show map", "explore", "build"].sort
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
      death = rand(1..100)
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
  input = gets.chomp
  map.visit(input)
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

    when "build", "repair base", "repair", "barricade"
      base.repair

    when "scavenge", "find supplies"
      scavenge(base, map)

    when "explore"
      if player.ready?
        if explore(map)
          $spoils = []
          (Explore.new).encounter
          player.tired
          if $spoils != []
            base.scav_success($spoils[1], $spoils[0])
          end
        end
      else
        puts "You've already been scavenging today!"
      end

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
