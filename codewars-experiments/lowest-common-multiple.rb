# For a 6 kyu kata concerning finding the lowest common multiple of a set of odd numbers within an array

def kiyo_lcm(a)
  odd_num = [1, 3, 5, 7, 9]
  y = [] ; final = []

  for x in 0..(a.length - 1)

    for i in 0..8

      if odd_num.include?(a[x][i])
        y.push(a[x][i])
      end

    end

    final.push(y.inject(0, :+))
    y = []

  end

  final.reduce(:lcm)

end
