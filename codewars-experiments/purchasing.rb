# Long and fairly overly complex, but a solution to a purchasing Kata.

box = "mon mon mon mon mon apple mon mon mon mon mon mon mon monme mon mon monme mon mon mon mon cloth monme mon mon mon mon mon mon mon mon cloth mon mon monme mon mon mon mon monme mon mon mon mon mon mon mon mon mon mon mon mon mon"
big_coins = box.scan(/monme/).count
total_coins = box.scan(/mon/).count
little_coins = total_coins - big_coins
total_wealth = (big_coins * 60) + (little_coins)
cost = 124
total = 0
array = [little_coins, big_coins, total_wealth]
if cost < 60
  if little_coins < cost
    puts "leaving the market"
  else
    puts array.push(cost)
  end
elsif cost > total_wealth
  puts "leaving the market"
else
    monme_num = 0
  until ((total > cost) || (monme_num == big_coins)) do
    monme_num += 1
    total += 60
  end
  if monme_num == big_coins
    if cost == (big_coins * 60)
      puts array.push(big_coins)
    else
      remaining = cost - (big_coins * 60)
      if remaining > little_coins
        puts "leaving the market"
      else
        final_value = remaining + big_coins
        puts array.push(final_value)
      end
    end
  else
    x = total - 60
    monme_num -= 1
    mon_num = cost - x
    if mon_num > little_coins
      puts "leaving the market"
    else
      final_value = monme_num + mon_num
      puts array.push(final_value)
    end
  end
end
