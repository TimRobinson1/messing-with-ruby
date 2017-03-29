require 'yaml'

# Starting character statistics
class Player
  def initialize(name)
    @name = name
    @inventory = ""
    @has_weapon = false
    @health = 100
    @feeling = "a bit confused"
    @location = "start_woods"
  end

  def print_name
    @name
  end

  def where?
    @location
  end

  def location(area)
    @location = area
  end

  def save
    [@name, @inventory, @has_weapon, @health, @feeling, @location]
  end

  def load(l)
    @name, @inventory, @has_weapon = l[0], l[1], l[2]
    @health, @feeling, @location = l[3], l[4], l[5]
  end
end

class Defeat
  def initialize(enemy)
    types = ["vicious", "monstrous", "murderous", "very evil", "powerful"]
    version = types[rand(0..4)]
    messages = ["That #{version} #{enemy} made very quick work of you!", "Whoops, turns out that #{enemy} was #{version}. Too bad for you.", "You really thought you could beat that #{version} #{enemy}?", "Ouch, that #{enemy} pulverized you.", "Dead! Hopefully the #{enemy} will make funeral arrangements too."]
    puts messages[rand(0..4)]
    puts "Game over!"
  end
end

class Area
  def initialize(player)
    @prev_area = player.where?
  end

  def help
    puts "General commands:"
    puts "1. 'check inventory' - Displays current inventory."
    puts "2. 'check health' - Displays current health level."
    puts "3. 'show feelings' - Displays characater's current emotional state."
    puts "3. 'save game' - Saves progress to 'saves.yml'"
    puts "4. 'load game' - Loads progress from 'saves.yml'"
  end
end

def save_progress(player)
  # For saving progress
  File.open('saves.yml','w') do |h|
     h.write player.save.to_yaml
  end
end

def load_progress(player)
  # For loading player progress
  puts "Loading..."
  progress = YAML.load_file('saves.yml')
  player.load(progress)
  puts "Your hero, #{player.print_name}, has loaded successfully!"
end

def town_shop
  puts "You enter the town shop and see a variety of items for sale."
  puts "Only a few things catch your eye."
  puts "Health Potion - 100 gold coins."
  puts "Lottery Ticket - 1 gold coin."
  puts "Old warrior's sword - 50 gold coins."
  puts "You realise that you have no money, and are forced to leave."
  print "You return to town."
end

def start_woods
  puts "You find yourself in a dark wood. A winding path stretches in front of you\nto the North. There is also a darker path leading East. What do you do?"
  while true do
    input = gets.chomp.downcase
    if input.include?("north")
      puts "Heading North!"
    elsif input.include?("east")
      puts "Heading East!"
    elsif input.include?("inventory")
      puts "Inventory!"
    elsif input.include?("help")
      puts help
    else
      puts "I don't understand '#{input}'"
    end
  end
end

puts "Welcome to the game!"
puts "Would you like to load a previous game?"
input = gets.chomp
if input.downcase == "yes"
  load_progress(player = Player.new('Player'))
else
  puts "Starting a new game!"
  print "Name your hero: "
  input = gets.chomp
  player = Player.new(input)
end

puts "With a sharp pain in your head, you awaken."
send("#{player.where?}")
