# Simple 7 kyu Kata solution for searching strings for number of alphanumeric characters.

string = "hel2!lozr qs >!:@B£23f k"

string.downcase!

puts (string.count "a-z") + (string.count "0-9")
