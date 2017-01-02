# Used to determine whether 3 integers can create a triangle of those lengths.

def isTriangle(a,b,c)
   if (((b+c) > a) && ((a+c) > b)) && ((a+b) > c)
     return true
  else
    return false
  end
end
