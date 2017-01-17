# 5 kyu kata for removing trailing zeros from large factorials.

def zeros(n)
  return 0 if n.zero?
  k = (Math.log(n)/Math.log(5)).to_i
  x = (5**k)
  n*(x-1) / (4*x)
end

# An extremely efficient solution found on Codewars:

# def zeroes(n)
  # n < 5 ? 0 : (n / 5) + zeros(n / 5)
# end
