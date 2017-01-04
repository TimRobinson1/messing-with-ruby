# repeater('a', 5) should return five a's, as in "aaaaa"

def repeater(string, n)
  return "\"#{string}\" repeated #{n} times is: \"#{string*n}\""
end
