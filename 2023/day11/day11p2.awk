# Advent of Code 2023 day 11 part 1 in awk
## Author: Chris Menard

BEGIN {
    factor = 1000000
}

function print_input(     i) {
    for (i=1; i<=length(input); i++) {
	print input[i]
    }
}

function abs(number) {
    return number > 0 ? number : -number
}

# Expands the input, also finds galaxies
function pre_expand(     i,     j,     str,     char,     count) {
    count = 1
    
    for (i=1; i<=length(input); i++) {
	if (input[i] ~ /^\.+$/) {
	    y[i] = ""
	}
    }
    
    for (i=1; i<=length(input[1]); i++) {
	str = ""
	
	for (j=1; j<=length(input); j++) {

	    char = substr(input[j],i,1)
	    if (char == "#") {
		gals[count] = i "," j
		count++
	    }
		
	    str = str substr(input[j],i,1)
	}
	
	if (str ~ /^\.+$/) {
	    x[i] = ""
	}
    }
}

function expand(     idx,     vals,     i,    galx,    galy) {
    
    for (idx in gals) {
	galx = 0
	galy = 0
	split(gals[idx],vals,",")

	# convert to numbers
	vals[1] += 0
	vals[2] += 0

	for (i in x) {
	    i += 0
	    if (vals[1] > i) {
		galx++
	    }
	}
	
	for (i in y) {
	    i += 0
	    if (vals[2] > i) {
		galy++
	    }
	}

	vals[1] += galx*(factor-1)
	vals[2] += galy*(factor-1)

	gals[idx] = vals[1] "," vals[2]
    }
}

    


/[.]/ {
    input[NR] = $1
}

END {
    pre_expand()
    expand()

    for (i=1; i<=length(gals)-1; i++) {
	for (j=i+1; j<=length(gals); j++) {
	    split(gals[i],first,",")
	    split(gals[j],second,",")

	    dist = abs(second[2] - first[2]) + abs(second[1] - first[1])
	    tot += dist

	}
    }

    print tot
}
