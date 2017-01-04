# Highest and Lowest Kata

number = "8 5 29 54 4 0 -214 542 -64 1 -3 -6"
a = number.split(" ").map(&:to_i)
puts "#{a.max} #{a.min}"
