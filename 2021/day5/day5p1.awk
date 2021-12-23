# Advent of Code 2021, day 5 part 1
## Author: Chris Menard

BEGIN { FS = "[ ,]" }

/[0-9]+,[0-9]+ -> [0-9]+,[0-9]+/ { #Line format: $1,$2 -> $4,$5
    if ($1 == $4) { # Vertical line
	
	if ($2 > $5) {
	    y1 = $5
	    y2 = $2
	}
	else {
	    y1 = $2
	    y2 = $5
	}
	
	for (y=y1; i<=y2; y++) {
	    linecoords[$1,y]++
	}
    }
    if ($2 ==$5) { # Horizontal line
	if ($1 > $4) {
	    x1 = $4
	    x2 = $1
	}
	else {
	    x1 = $1
	    x2 = $4
	}

	for (x=x1; x<=x2; x++) {
	    linecoords[x,$2]++
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



	
