# A bare starting point for a text-based adventure.
$inventory = ""

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
    if input.split(" ").any? { |x| ["fight", "kill", "attack", "punch", "hit", "murder", "stab"].include? x }
      puts "You fought the troll and won!"
      exit
    elsif input.split(" ").any? { |x| ["run", "flee", "go back", "leave", "return"].include? x }
      puts "You attempt to reutrn to the previous area, but that hasn't been implemented yet."
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
end

puts "You awaken in a dark wood. A winding path stretches in front of you
to the North. There is also a darker path leading East. What do you do?"

def start_woods
  loop do
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
