# An excellent solution to a Codewars kata I saw and thought to save.
# Vastly refactored version of my own solution

customers = [792, 2, 551, 84, 15, 96, 68, 10, 761]
# Cusomter numbers are times, n is the number of tills open. Find min time taken to process.
n = 6
# Answer: 792

def queue_time(customers, n)
  arr = Array.new(n, 0)
  customers.each do |customer|
    arr[arr.index(arr.min)] += customer
  end
  arr.max
end

queue_time(customers, n)
