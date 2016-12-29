arr = [6, 1, 6, 4, 6, 1, 2, 8, 2, 0]
puts arr.inject{ |sum, el| sum + el }.to_f / arr.size
