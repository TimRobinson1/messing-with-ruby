# For determining if integer values are palindromes

new_array = []
numbers = [22, 303, 76, 411, 89]
x = 0
until x == numbers.length
  reverse = (numbers[x].to_s.reverse!).to_i
  answer = numbers[x] - reverse
  x += 1
  if answer == 0
    new_array.push(1)
  else
    new_array.push(0)
  end
end

return new_array

# Below is a much more efficient solution.

#     def convert_palindromes(numbers)
#      numbers.map {|num| num.to_s.reverse == num.to_s ? 1 : 0}
#     end
