# Advent of Code 2021, day 17 part 2
## Author: Chris Menard

# vertical position after n steps for initial velocity y is n*y - n(n-1)/2 (n-1 triangular number)
# so, for a position ypos and step n, the initial y velocity is (ypos+n(n-1)/2)/n and is only possible
# if this is an integer
#
# Note that if the initial vertical velocity y>0, then there will be a step when the y position = 0 and
# and the y velocity will be the inverse of the starting y velocity yinit. Therefore, if -yinit-1 < ymax
# we have found the greatest the y velocity can be
#
# horizontal position after n steps with an initial velocity of x is the same formula, just with a
# max position of x(x+1)/2 (xth triangular number)
# therefore, if we take the max of (-1 +/- sqrt(1+8xpos))/2 and (xpos+n(n-1)/2)/n for step n and
# horizontal position xpos, then x is a valid velocity if this is an integer


BEGIN {
    FS = "[ =.,]"
}

/target area:/ {
    xmin = $4
    xmax = $6
    ymin = $9
    ymax = $11
}

END {
    count = 0
    
    # Find minimum x velocity
    xvelmin = (-1 + sqrt(1+ 8*xmin))/2

    # Round up if necessary
    if (xvelmin%1 != 0)
	xvelmin = int(xvelmin) + 1

    # maximum x velocity takes us to the very end of the area
    xvelmax = xmax
    
    # minimum y velocity is the lower limit
    yvelmin = ymin

    # maximum y velocity is 1 less than the opposite of the lower limit
    yvelmax = -ymin - 1

    for (xvel=xvelmin; xvel<=xvelmax; xvel++) {

	xposmax = xvel*(xvel+1)/2

	for (yvel=yvelmin; yvel<=yvelmax; yvel++) {

	    step = 0
	    xmaxreached = 0

	    while (++step) {

		xpos = xvel*step - step*(step-1)/2
		
		# If we've reached the maximum x position, use that going forward
		if (xmaxreached ==1) 
		    xpos = xposmax
		else 
		    xposmax == xpos ? xmaxreached = 1 : xmaxreached = 0

		ypos = yvel*step - step*(step-1)/2

		# If we're past the target zone, stop trying
		if (ypos < ymin || xpos > xmax)
		    break
		# If we're in the target zone, increment and stop trying
		else if (ymin <= ypos &&
			 ypos <= ymax &&
			 xmin <= xpos &&
			 xpos <= xmax) {
		    count++
		    break
		}
	    }
	}
    }

    print count
}
