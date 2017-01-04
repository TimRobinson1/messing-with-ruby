# This code is not my own but is an elegant solution.

def partlist(arr)
    (1...arr.size).map { |i|
      [arr.take(i).join(' '), arr.drop(i).join(' ')]
    }
end
