# Advent of Code 2023 day 14 part 2 in awk
# Author: Chris Menard

BEGIN {
    iters = 1000000000
}

function print_input(     i) {
    for (i=1; i<=length(input); i++) {
	print input[i]
    }
    print ""
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

function rollS(     anchor,     i,     j,     val) {

    for (i=1; i<=length(input[1]); i++) {
	anchor = length(input)+1
	
	for (j=length(input); j>=1; j--) {
	    val = substr(input[j],i,1)

	    if (val == "#") {
		anchor = j
	    } else if (val == "O") {
		input[j] = substr(input[j],1,i-1) "." substr(input[j],i+1)
		input[anchor-1] = substr(input[anchor-1],1,i-1) "O" substr(input[anchor-1],i+1)
		anchor--
	    }
	}
    }
}

function rollW(     anchor,     i,     j,     val) {

    for (i=1; i<=length(input); i++) {
	anchor = 0
	
	for (j=1; j<=length(input[1]); j++) {
	    val = substr(input[i],j,1)

	    if (val == "#") {
		anchor = j
	    } else if (val == "O") {
		input[i] = substr(input[i],1,j-1) "." substr(input[i],j+1)
		input[i] = substr(input[i],1,anchor) "O" substr(input[i],anchor+2)
		anchor++
	    }
	}
    }
}

function rollE(     anchor,     i,     j,     val) {

    for (i=1; i<=length(input); i++) {
	anchor = length(input[1])+1
	
	for (j=length(input[1]); j>=1; j--) {
	    val = substr(input[i],j,1)

	    if (val == "#") {
		anchor = j
	    } else if (val == "O") {
		input[i] = substr(input[i],1,j-1) "." substr(input[i],j+1)
		input[i] = substr(input[i],1,anchor-2) "O" substr(input[i],anchor)
		anchor--
	    }
	}
    }
}

/[O.#]+/ {
    input[NR] = $1
}

END {
    for (i=1; i<=iters; i++) {
	rollN()
	rollW()
	rollS()
	rollE()

	tot = 0
	for (j=1; j<=length(input); j++) {
	    tot += (length(input)  + 1 - j)*gsub(/O/,"0",input[j])
	    gsub(/0/,"O",input[j])
	}

	vals[tot]++

	if (i > 100)
	    cycles[tot] = cycles[tot] "," i
	
	if (vals[tot] > 1 && i > 100) {
	    split(cycles[tot],nums,",")

	    # extrapolate cycles to see which one matches iters
	    if (nums[3]-nums[2] > 1 && (iters-nums[2]) % (nums[3]-nums[2]) == 0) {
		print tot
		break
	    }
	}
    }
}

