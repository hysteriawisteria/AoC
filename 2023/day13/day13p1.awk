# Advent of Code 2023 day 13 part 1 in awk
## Author: Chris Menard

function checkv(     i,     j,     k,     ref) {

    for (i=1; i<=length(input[1])-1; i++) {

	ref = 1
	for (k=1; k<=length(input); k++) {

	    for (j=0; i-j>=1 && i+j<=length(input[1])-1; j++) {
		
		if (substr(input[k],i-j,1) != substr(input[k],i+j+1,1)) {
		    ref = 0
		    break
		}
	    }

	    if (!ref)
		break
	}
	if (ref)
	    return i
    }

    return 0
}

function checkh(     i,     j,      k,     ref) {

    for (i=1; i<=length(input)-1; i++) {

	ref = 1
	for (k=1; k<=length(input[1]); k++) {

	    for (j=0; i-j>=1 && i+j<=length(input)-1; j++) {

		if (substr(input[i-j],k,1) != substr(input[i+j+1],k,1)) {
		    ref = 0
		    break
		}
	    }

	    if (!ref)
		break
	}
	if (ref)
	    return i
    }

    return 0
}

    

/[.#]+/ {
    input[NR-off] = $1
}

/^$/ {
    v = checkv()
    h = checkh()
    off = NR
    delete input
    tot += 100*h+v
}

END {
    v = checkv()
    h = checkh()
    tot += 100*h+v

    print tot
}
