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

def north_route
  puts "Going North"
end

def east_route
  puts "Going East"
end

def help
  puts "General commands:"
  puts "1. 'check inventory' - Displays current inventory."
end

puts "You awaken in a dark wood. A winding path stretches in front of you
to the North. There is also a darker path leading East. What do you do?"

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
