# Advent of Code 2021, day 9 part 1
## Author: Chris Menard

function lowPoint(array,x1,y1) { # Check if point x1,y1 is a low point in the array
    
    if (y1 == 1)
	up=9
    else
	up=substr(array[y1-1],x1,1)

    if (y1 == length(array))
	down=9
    else
	down=substr(array[y1+1],x1,1)

    if (x1 == 1)
	left=9
    else
	left=substr(array[y1],x1-1,1)

    if (x1 == length(array[y1]))
	right=9
    else
	right=substr(array[y1],x1+1,1)

    val = substr(array[y1],x1,1)
    if (val < up &&
	val < down &&
	val < left &&
	val < right)
	return 1 + val
    else
	return 0
}


    


/[0-9]+/ {terrain[NR]=$1}

END {
    
    total=0
    for (y=1; y<=length(terrain); y++) {
	for (x=1; x<=length(terrain[y]); x++) {
	    total+=lowPoint(terrain,x,y)
	}
    }

    print total
}
