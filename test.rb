# Takes the command line input and makes it the filename variable
filename = ARGV.first

# Sets the txt variable to the command of opening the variable 'filename'
txt = open(filename)

# Prints out the file contents with a header and file title.
puts "Here's your file #{filename}:"
print txt.read
