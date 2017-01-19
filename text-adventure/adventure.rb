# A bare starting point for a text-based adventure.

# Starting character statistics
$inventory = ""
$has_weapon = false
$health = 100
$feeling = "a bit confused"

def fight_mode(input)
  input.split(" ").any? { |x| ["fight", "kill", "attack", "punch", "hit", "murder", "stab"].include? x }
end

def flee_mode(input)
  input.split(" ").any? { |x| ["flee", "run", "retreat", "fall back", "hide"].include? x }
end

def talk_mode(input)
  input.split(" ").any? { |x| ["talk", "chat", "converse", "speak"].include? x }
end

def get_inventory
  if $inventory.empty?
    inventory = "nothing"
  else
    inventory = $inventory
  end
  puts "Current inventory: #{inventory}"
end

def generic_responses
    if $input.include?("inventory")
      get_inventory
    elsif $input.split(" ").any? { |x| ["health", "check health", "show health", "display health"].include? x }
      puts "Your current health is: #{$health}"
    elsif $input.include?("help")
      help
    elsif $input.split(" ").any? { |x| ["show feelings", "check feelings", "show feeling", "check feeling", "feelings"].include? x }
      puts "Currently, you are feeling #{$feeling}."
    else
      puts "You're unsure what to do."
    end
end

def dead
  x = rand(0..4)
  message = ["You died! Way to go, hero.", "Death ensnares your twitching corpse.", "You got yourself killed!", "You're dead! And you were so young.", "Death comes for us all, it just came for you faster."]
  puts message[x]
  puts "Game over!"
  exit(0)
end

def north_route
  puts "You head north and a troll stands in front of you.\nHe appears to want to test the fight function."
  $feeling = "a bit scared"
  loop do
    input = gets.chomp.downcase
    if fight_mode(input) && $has_weapon
      puts "You beat the troll!"
      exit(0)
    elsif fight_mode(input)
      puts "You try to fight the troll, but you're unarmed.\nThe troll makes quick work of you."
      dead
    elsif flee_mode(input)
      puts "You flee back to the previous area!"
      $feeling = "a bit shaken up"
      start_woods
    elsif talk_mode(input)
      puts "You try to communicate, but the Troll only\nunderstands the Trollian language."
    else
      $input = input
      generic_responses
    end
  end
end

def east_route
  puts "You decide to head east and come upon a small village."
  puts "From where you're standing, you can see a shop,\na tavern and a town hall. What do you do?"
  loop do
    input = gets.chomp.downcase
    if input.include?("tavern")
      puts "Heading to tavern!"
    elsif input.include?("shop")
      puts "Heading to the shop!"
    elsif input.include?("hall")
      puts "Heading to town hall!"
    else
      $input = input
      generic_responses
    end
  end
end

def help
  puts "General commands:"
  puts "1. 'check inventory' - Displays current inventory."
  puts "2. 'check health' - Displays current health level."
  puts "3. 'show feelings' - Displays characater's current emotional state."
  puts "3. 'save game' - Saves progress to 'saves.csv'"
  puts "4. 'load game' - Loads progress from 'saves.csv'"
end

def start_woods
  puts "You find yourself in a dark wood. A winding path stretches in front of you\nto the North. There is also a darker path leading East. What do you do?"
  while true do
    input = gets.chomp.downcase
    if input.include?("north")
      north_route
    elsif input.include?("east")
      east_route
    elsif input.include?("inventory")
      inventory
    elsif input.include?("help")
      help
    else
      $input = input
      generic_responses
    end
  end
end

puts "With a sharp pain in your head, you awaken."
start_woods
