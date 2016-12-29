# [3.6, "udiwstagwo"]

corner = ['u', '6', 'd', '1', 'i', 'w', '6', 's', 't', '4', 'a', '6', 'g', '1', '2', 'w', '8', 'o', '2', '0']

# letters.push('f')

numbers = []
letters = []

for i in 0..19
  if ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].include? corner[i]
    numbers.push((corner[i].to_i))
  else
    letters.push(corner[i])
  end
end

letters.join()
numbers.inject{ |sum, el| sum + el }.to_f / numbers.size

final_array = [(numbers.inject{ |sum, el| sum + el }.to_f / numbers.size), (letters.join())]

puts final_array
