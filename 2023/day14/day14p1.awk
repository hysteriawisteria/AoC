# Advent of Code 2023 day 14 part 1 in awk
# Author: Chris Menard

function print_input() {
    for (i=1; i<=length(input); i++) {
	print input[i]
    }
}

function rollN(     anchor,     i,     j,     val) {

    for (i=1; i<=length(input[1]); i++) {
	anchor = 0
	
	for (j=1; j<=length(input); j++) {
	    val = substr(input[j],i,1)

	    if (val == "#") {
		anchor = j
	    } else if (val == "O") {
		input[j] = substr(input[j],1,i-1) "." substr(input[j],i+1)
		input[anchor+1] = substr(input[anchor+1],1,i-1) "O" substr(input[anchor+1],i+1)
		anchor++
	    }
	}
    }
}

/[O.#]+/ {
    input[NR] = $1
}

END {
    rollN()

    for (i=1; i<=length(input); i++) {
	tot += (length(input)  + 1 - i)*gsub(/O/,".",input[i])
    }

    print tot
}

