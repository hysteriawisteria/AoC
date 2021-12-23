# Advent of Code 2021, day 5 part 2
## Author: Chris Menard

function print_coords(coords,x_max,y_max) {
    for (y=0; y<=y_max; y++) {
	for (x=0; x<=x_max; x++) {
	    if (coords[x,y] != "")
		printf "%d", coords[x,y]
	    else
		printf "."
	}
	printf "\n"
    }
}

BEGIN { FS = "[ ,]" }

/[0-9]+,[0-9]+ -> [0-9]+,[0-9]+/ { #Line format: $1,$2 -> $4,$5
    if ($2 > $5) {
	y1 = $5
	y2 = $2
    }
    else {
	y1 = $2
	y2 = $5
    }

    if ($1 > $4) {
	x1 = $4
	x2 = $1
    }
    else {
	x1 = $1
	x2 = $4
    }

    if ($1 == $4) { # Vertical line	
	for (y=y1; y<=y2; y++) {
	    linecoords[$1,y]++
	}
    }
    else if ($2 ==$5) { # Horizontal line

	for (x=x1; x<=x2; x++) {
	    linecoords[x,$2]++
	}
    }
    else { # Diagonal line
	x=$1
	y=$2
	linecoords[x,y]++
	while (x != $4) {
	    if ($1 >$4)
		x--
	    else
		x++
	    if ($2 >$5)
		y--
	    else
		y++
	    linecoords[x,y]++
	}
    }
}

END {
    total = 0
    for (combined in linecoords) {
	if (linecoords[combined] > 1)
	    total++
    }
    print total
}
