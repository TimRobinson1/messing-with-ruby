# A bare starting point for a text-based adventure.
$inventory = ""

def fight_mode(input)
  input.split(" ").any? { |x| ["fight", "kill", "attack", "punch", "hit", "murder", "stab"].include? x }
end

def inventory
  if $inventory.empty?
    inventory = "nothing"
  else
    inventory = $inventory
  end
  puts "Current inventory: #{inventory}"
end

def response
  loop do
    input = gets.chomp.downcase
    if fight_mode(input)
      puts "You fought the troll and won!"
      exit
    elsif input.split(" ").any? { |x| ["run", "flee", "go back", "leave", "return"].include? x }
      puts "You run back to the previous area."
      a = caller[0][/`([^']*)'/, 1]
      puts caller[a]
    elsif input.include?("inventory")
      inventory
    elsif input.include?("help")
      help
    else
      puts "What?"
    end
  end
end

def north_route
  puts "You head north and a troll stands in front of you.
  He appears to want to test the fight function."
  response
end

def east_route
  puts "Going East"
end

def help
  puts "General commands:"
  puts "1. 'check inventory' - Displays current inventory."
  puts "2. 'flee' or 'run' - Returns player to previous area if possible."
  puts "3. 'save game' - Saves progress to 'saves.csv'"
  puts "4. 'load game' - Loads progress from 'saves.csv'"
end

def start_woods
  puts "You awaken in a dark wood. A winding path stretches in front of you
  to the North. There is also a darker path leading East. What do you do?"
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
      puts "What?"
    end
  end
end

start_woods
