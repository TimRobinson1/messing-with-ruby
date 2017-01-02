def count_by(x, n)
  time = 1
  $my_array = []
  while n >= time
    result = (x*time)
    time += 1
    $my_array.push(result)
  end
  puts $my_array
end

# 2 4 6 8 10
