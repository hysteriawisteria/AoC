# Advent of Code 2021, day 5 part 1
## Author: Chris Menard

BEGIN { FS = "[ ,]" }

/[0-9]+,[0-9]+ -> [0-9]+,[0-9]+/ { #Line format: $1,$2 -> $4,$5
    if ($1 == $4) { # Vertical line
	
	if ($2 > $5) {
	    start = $5
	    end = $2
	}
	else {
	    start = $2
	    end = $5
	}
	
	for (i=start; i<=end; i++) {
	    linecoords[$1,i]++
	}
    }
    if ($2 ==$5) { # Horizontal line
	if ($1 > $4) {
	    start = $4
	    end = $1
	}
	else {
	    start = $1
	    end = $4
	}

	for (i=start; i<=end; i++) {
	    linecoords[i,$2]++
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



	
