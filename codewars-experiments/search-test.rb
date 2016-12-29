def find_char(test_var)
  if ["Dog", "Cat", "Mouse", "Bearcat"].include?(test_var) == true
    puts "It had the word in there!"
  else
    puts "Nope, not there!"
  end
end

find_char("arc")

# This works with both strings and numbers for searching an array.
