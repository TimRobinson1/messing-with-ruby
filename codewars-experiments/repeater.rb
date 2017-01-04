# repeater('a', 5) should return five a's, as in "aaaaa"

def repeater(string, n)
  new_string = string
  x = 1
  until x == n do
    new_string += string
    x += 1
  end
  puts new_string
end

# Using 'string*n' also works!
