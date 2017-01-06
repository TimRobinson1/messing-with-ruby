#fighters = [
#    ["Ryu", "E.Honda", "Blanka", "Guile", "Balrog", "Vega"],
#    ["Ken", "Chun Li", "Zangief", "Dhalsim", "Sagat", "M.Bison"]
#]

moves = ["right", "right", "down", "right", "right", "right", "right", "up"]

top = fighters[0]
  bottom = fighters[1]

  pos = [0,0]
  f = []
  ans = []
  if pos[0] == 0
    f = top
  else
    f = bottom
  end
  x = 0
  until x == moves.length do
    case moves[x]
    when "left"
      if pos[1] == 0
        pos[1] = 5
        ans.push(f[pos[1]])
      else
        pos[1] -= 1
        ans.push(f[pos[1]])
      end
    when "right"
      if pos[1] == 5
        pos[1] = 0
        ans.push(f[pos[1]])
      else
        pos[1] += 1
        ans.push(f[pos[1]])
      end
    when "up"
      fighters = top
      ans.push(f[pos[1]])
    when "down"
      fighters = bottom
      ans.push(f[pos[1]])
    else
      puts "Fail"
    end
    x += 1
  end

return ans

#initial_position = (0,0)
#moves = ['up', 'left', 'right', 'left', 'left']

#['Ryu', 'Vega', 'Ryu', 'Vega', 'Balrog']
