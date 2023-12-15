# Advent of Code 2023 day 15 part 1 in awk
## Author: Chris Menard

BEGIN {
    for (i=7; i<128; i++) {
	_ord_[sprintf("%c",i)] = i
    }
}

function ascii(c) {
    return _ord_[c]
}

/[\x00-\x7F]+/ {
    split($1,input,",")

    for (i=1; i<=length(input); i++) {

	hash = 0
	for (j=1; j<=length(input[i]); j++) {
	    hash = ((hash + ascii(substr(input[i],j,1))) * 17) % 256
	}
	tot += hash
    }
}
    

END {
    print tot
}



