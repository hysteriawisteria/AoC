# Advent of Code 2021, day 9 part 2
## Author: Chris Menard

function up(array,x1,y1) {
    if (y1 == 1)
	return 9
    else
	return substr(array[y1-1],x1,1)
}

function down(array,x1,y1) {
    if (y1 == length(array))
	return 9
    else
	return substr(array[y1+1],x1,1)
}

function left(array,x1,y1) {
    if (x1 == 1)
	return 9
    else
	return substr(array[y1],x1-1,1)
}

function right(array,x1,y1) {
    if (x1 == length(array[y1]))
	return 9
    else
	return substr(array[y1],x1+1,1)
}
 
function lowPoint(array,x1,y1) { # Check if point x1,y1 is a low point in the array
    
    val = substr(array[y1],x1,1)
    if (val < up(array,x1,y1) &&
	val < down(array,x1,y1) &&
	val < left(array,x1,y1) &&
	val < right(array,x1,y1))
	return findBasin(array,x1,y1)
    else
	return 0
}

function findBasin(array,x1,y1) {
    # Recursively find the size of the current basin
    
    # This always starts from a low point, so we should be able to replace the current point with a '9'
    # and then recursively check up, right, down, left

    # Base case is we're outside of the terrain, or the point is a ridge (=9)
    
    if ( x1 == 0 ||
	 y1 == 0 || 
	 y1 > length(array) ||
	 x1 > length(array[y1]) ||
	 substr(array[y1],x1,1) == 9) {
	
	return 0
    }
    else {
	if (x1 == 1)
	    first = ""
	else
	    first = substr(array[y1],1,x1-1)

	if (x1 == length(array[y1]))
	    last = ""
	else
	    last = substr(array[y1],x1+1)

	array[y1] = first "9" last

	return 1 + findBasin(array,x1-1,y1) + findBasin(array,x1,y1-1) + findBasin(array,x1+1,y1) + findBasin(array,x1,y1+1)
    }
}

function printTerrain(array) {
    for (i in array) {
	printf "%s: %s\n",i,array[i]
    }
    printf "\n"
}
    


/[0-9]+/ {terrain[NR]=$1}

END {
    
    totArr[1]=0
    totArr[2]=0
    totArr[3]=0
    
    for (y=1; y<=length(terrain); y++) {
	for (x=1; x<=length(terrain[y]); x++) {
	    
	    basin_size=lowPoint(terrain,x,y)

	    # See if the basin sizes is larger than
	    basin_size > totArr[1] ? totArr[1] = basin_size : totArr[1]=totArr[1]
	    asort(totArr)
	}
    }

    print totArr[1] * totArr[2] * totArr[3]
}

