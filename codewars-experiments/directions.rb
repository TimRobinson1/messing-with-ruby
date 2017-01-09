# A work in progress to remove unnecessary directions.

# a = ["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]
# Should produce: ["WEST"]

a = ["NORTH", "SOUTH", "SOUTH", "EAST", "WEST", "NORTH", "WEST"]

x = 0
until x == a.length do
  if ((a[x] == "NORTH") && (a[x+1] == "SOUTH") || (a[x] == "SOUTH") && (a[x+1] == "NORTH"))
    puts "test"
    x += 1
  elsif ((a[x] == "EAST") && (a[x+1] == "WEST") || (a[x] == "WEST") && (a[x+1] == "EAST"))
    a.delete_at(x) ; a.delete_at(x+1)
    x += 1
  else
    puts "Done"
    x += 1
  end
end

puts a
