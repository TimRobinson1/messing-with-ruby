# This text based adventure is being used primarily to test and learn about
# classes and the basics of object-oriented programming with Ruby.
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

  def test_name_change(input)
    @name = input
  end

  def where?
    @location
  end

  def alive?
    if @health > 0
      true
    else
      false
    end
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
    @player = player
  end

  def help
    puts "General commands:"
    puts "1. 'check inventory' - Displays current inventory."
    puts "2. 'check health' - Displays current health level."
    puts "3. 'show feelings' - Displays characater's current emotional state."
    puts "3. 'save game' - Saves progress to 'saves.yml'"
  end
end

class StartWoods < Area
  def first_time
    puts "You find yourself in a dark wood. A winding path stretches in front of you\nto the North. There is also a darker path leading East. What do you do?"
    while @player.alive? do
      input = gets.chomp.downcase
      case input
      when "north", "go north", "head north"
        NorthWoods.new(@player).first_time
      when "save", "save game", "save progress"
        ProgressLog.new(@player).save_game
      when "inventory", "check inventory"
        puts "Inventory!"
      when "help"
        help
      else
        puts "I don't understand '#{input}'"
      end
    end
    puts "Dead!"
  end
end

class NorthWoods < Area
  def first_time
    while @player.alive? do
    puts "You arrive in the northern woods."
    input = gets.chomp.downcase
      case input
      when "save", "save game", "save progress"
        ProgressLog.new(@player).save_game
      when "inventory", "check inventory"
        puts "Inventory!"
      when "help"
        help
      else
        puts "I don't understand '#{input}'"
      end
    end
  end
end

class ProgressLog
  def initialize(player)
    @progress = player
  end

  def save_game
    File.open('saves.yml','w') do |h|
       h.write @progress.save.to_yaml
    end
    puts "Game saved successfully."
  end

  def load_game
    # For loading player progress
    puts "Loading..."
    status = YAML.load_file('saves.yml')
    @progress.load(status)
    puts "Your hero, #{@progress.print_name}, has loaded successfully!"
  end
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

puts "Welcome to the game!"
puts "Would you like to load a previous game?"
input = gets.chomp
if input.downcase == "yes"
  ProgressLog.new(player = Player.new('Player')).load_game
else
  puts "Starting a new game!"
  print "Name your hero: "
  input = gets.chomp
  player = Player.new(input)
end

puts "With a sharp pain in your head, you awaken."
StartWoods.new(player).first_time
