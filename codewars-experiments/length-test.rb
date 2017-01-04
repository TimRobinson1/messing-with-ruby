# Testing for names of four letters in length.  Learn Ruby the Hard Way says that there should be an else section to the if statement.

friends = ["Ryan", "Kieran", "Alexander", "123", "1234"]
x = 0
true_friends = []
until x == friends.length do
  if friends[x].length == 4
    true_friends.push(friends[x])
    x += 1
  else
    x += 1
  end
end
return true_friends


#  More efficient solution for future reference

#     def friend(friends)
#       friends.select { |name| name.length == 4 }
#     end
