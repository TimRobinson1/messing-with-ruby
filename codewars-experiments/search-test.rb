def find_char(test_var)
  if [1, 5, 9].include?(test_var) == true
    puts "It had the word in there!"
  else
    puts "Nope, not there!"
  end
end

find_char(3)

# This works with both strings and numbers for searching an array.
