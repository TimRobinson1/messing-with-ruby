def find_char(test_var)
  if ["Cat", "Dog", "Bird"].include?(test_var) == true
    puts "It had the word in there!"
  else
    puts "Nope, not there!"
  end
end

find_char('Dog')
