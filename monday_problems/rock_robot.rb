# A robot is on an infinite grid, starting at position (0,0)
# At its feet are N rocks
# The robot understands the following commands: pick up a rock, put down a rock, 
# move forward, turn left, is there at least one rock at my feet?
#
# We will call these primitives: pick, put, move, turn, and rock?
#
# In addition, it has a while loop, if statement, negation, the ability to define 
# functions, and recursion.
#
# It does not, however, have any local storage
# Note: the robot has an infinite number of rocks in its pockets, 
# so "put" always results in a rock being placed
#
# Example program:
# while rock?
#   pick
# end
#   
# This program would just pick up all the rocks at the robot's feet.
#
# Problem:   Write a program in this language which results in the robot ending at (0,N)
#              if it starts at (0,0) with N rocks at its feet

  #What direction does it start out facing? I'm assuming it's facing up to begin with


def turn_around
  turn
  turn
end

def only_one_rock?
  pick
  if !rock?
    put
    true
  else
    put
    false
  end
end

def go_out
  pick
  while rock?
    move
  end
  put
  turn_around
end


def come_back
  while only_one_rock?
    move
  end
  turn_around
end

while rock?
  go_out
  come_back
end
move
go_out

# Problem 2: What if the each square has a random number of rocks placed on it, 
#              not just the starting square?
# 

def take
  pick
  move
  while only_one_rock?
    put
    move
  end
  clean
end



def clean
  while rock?
    pick
  end
end
    
  
    

# There is a linear-time solution in the number of starting rocks.  Can you find it?