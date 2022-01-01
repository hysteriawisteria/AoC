# Advent of Code 2021, day 17 part 1
## Author: Chris Menard

# Part 1 for this doesn't really need code
#
# In order for the probe to reach the highest altitude, the x velocity will be 0 over the target area,
# as that gives the most iterations possible for y to increment/decrement, so we can ignore the x velocity
#
# For y velocity > 0 (required to achieve a higher height than we start at), the vertical position will return
# back to 0 after 2*y steps. We want the y velocity to be as negative as possible at this point while still landing
# in the target zone. Since the y velocity at this point is equal to the starting y velocity, that means the starting
# y velocity is simply the negative of the lower bound of the target area minus one (since we get an extra one to our
# final y velocity step
#
# The maximum altitude is just the triangular number of the starting y velocity, or y * (y+1)/2

# Let's do that

BEGIN {
    FS = "[ =.,]"
}

/target area:/ {
    print (($9+1)*$9/2)
}
