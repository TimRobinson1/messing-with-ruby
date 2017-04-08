# Interesting units conversion kata -
# converting meters to kilometers, gigameters etc.

def meters(x)
  if x.to_s.length >= 25
    calculate(24, "Ym", x)
  elsif x.to_s.length >= 22
    calculate(21, "Zm", x)
  elsif x.to_s.length >= 19
    calculate(18, "Em", x)
  elsif x.to_s.length >= 16
    calculate(15, "Pm", x)
  elsif x.to_s.length >= 13
    calculate(12, "Tm", x)
  elsif x.to_s.length >= 10
    calculate(9, "Gm", x)
  elsif x.to_s.length >= 7
    calculate(6, "Mm", x)
  elsif x.to_s.length >= 4
    calculate(3, "km", x)
  else
    prefix = "#{x}m"
  end
end

def calculate(n, prefix, x)
  x = x.to_s.reverse.split("").insert(n, '.').reverse.join('').to_f.to_s
  if x.end_with?('.0')
    x.gsub!('.0', '') + prefix
  else
    x + prefix
  end
end

# Examples
puts meters(1000)
puts meters(10000000)
puts meters(10000000000000000)
